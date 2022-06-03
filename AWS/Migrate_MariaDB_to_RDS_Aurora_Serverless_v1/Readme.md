# AWS Database Migrate Service
### TASK: 
1. Migrate MariaDB to RDS Aurora Serverless v1
2. Problem solving in the migration process

## PART 1 - [Migrate MariaDB to RDS Aurora Serverless v1]

#### One of the most important aspects of any migration of data to the cloud is cost optimization. Luckily, AWS has made this relatively simple thanks to the Database Migration Service. I use the Database Migrations Service (DMS) to migrate a MariaDB database from an EC2 server to an RDS Aurora Serverless v.1 MySQL database.

### _Create Replication Instance_

1. Name our replication instance **aurorareplication**
2. Give it a Description of **mariadb to aurora**
3. Leave most of the defaults, but change the **Allocated storage 30**
4. Leave Multi-AZ unchecked
5. Uncheck publicly accessible
6. Choose the one with your VPC in the title from the dropdown, but for VPC security group select the security group for your databases.
7. Multi AZ: **YES**
8. Uncheck the **Publicly** accessible box
9. Click **Create**
<img src ='Screenshots/Replication_instance_done_1.png'>
<img src ='Screenshots/Replication_instance_done_2.png'>

### _Create Endpoints_
> Create a Target Endpoint

  1. Start off with our Target Endpoint
  2. Check the box for _RDS instance_
  3. Select **[name your database in RDS]** for the RDS instance
  4. Leave defaults:
     - Target Engine: **Amazon Aurora MySQL Serverless**
     - Keep the default **Server name**
     - Leave Port: **set to 3306**
     - leave `master_user(RDS)` as **User Name**
     - leave `master_password(RDS)` as **Password**
  5. Run test
  6. Create the Target Endpoint

> Create Source Endpoint

  8. Select **Source Endpoint**
  9. **Do not check the box** for _RDS instance_
  10. _Set Endpoint identifier_ to **my-db-source**
  11. Leave the defaults, and set _Source engine_ to **MariaDB**
  12. Set _Server Name_ to the **private IP** address your **instance with the database**
  13. Leave _Port_ set at **3306**, and leave `database_user(MariaDB)` as **User name**
  14. Paste your `password database(MariaDB)` into the **Password** field
  15. Run a test
  16. Create the source endpoint
<img src ='Screenshots/Endpoints_done.png'>

### _Create the Migration Task_

1. Add Identifier: **migratewordpress** (or anything other)
2. Choose our **Replication Instance**
3. Choose our **Source Endpoint**
4. Choose our **Target Endpoint**
5. _Check the box to make sure the task starts on creation_
6. Choose **Migration Type**
7. Choose to **not include large objects column**
8. Do **not enable validation** because it will take longer for creation
9. Leave CW logs unchecked
10. Leave default for Table mappings
11. Create new **Selection Rule**:
    - Leave Schema as default 
    - Leave Table name as default 
    - Set Schema name to wordpress (or your database) 
    - Leave Action set to Include
12. **Create the task**
<img src ='Screenshots/Migration_Task_Complete.png'>
<img src ='Screenshots/Migration_Task_Complete_2.png'>


## PART 2 - [Problem solving in the migration process]

> Error: "Index column size too large. The maximum column size is 767 bytes" While migrate database "moodle" using mysqldump from MariaDB to RDS Aurora Serverless

### What's the problem?
```
InnoDB engine (up to MySQL version 5.5.14) has the following limitations on the length of a field with a unique key:
- for utf8 encoding and TEXT and VARCHAR field types, the maximum field length is 255 bytes;
- for utf8mb4 encoding and TEXT and VARCHAR field types, the maximum field length is 191 bytes;

In utf8 (utf8mb3) encoding, one character takes 3 bytes, i.e. 3 * 255 gives us our 767 bytes limit.
In utf8mb4 encoding one character takes 4 bytes, that is 4 * 191 we get our 767 bytes limit.
```
### Backup all data
### Solution:

Since MySQL 5.6.3 there is an InnoDB_large_prefix option, which increases the limit from 767 bytes to 3072 bytes, but only for tables with DYNAMIC and COMPRESSED format rows and only for Barracuda file format (innodb_file_format=Barracuda) and only when the innodb_file_per_table=ON option is enabled. For COMPACT and REDUNDANT format strings the 767 bytes limit remains.

Given that in different MySQL versions the innodb_large_prefix, innodb_file_format and innodb_file_per_table parameters may or may not be enabled by default, it largely depends on knowing the MySQL version how to correctly solve the "Index column size too large. The maximum column size is 767 bytes.".

So, we need to configure these parameters correctly:
```
large_prefix = ON
file_format = Barracuda
file_per_table = ON
default_row_format = DYNAMIC
```
<img src ='Screenshots/Parameter_group.png'>

### Amazon Aurora MySQL does not support compressed tables.

If you check the amazon documentation https://docs.aws.amazon.com/dms/latest/sbs/chap-mysql2aurora.rdsmysql.html, it can be found that Aurora MySQL does not support compressed tables **(that is, tables created with ROW_FORMAT=COMPRESSED)**.

Ok. Let's check ROW_FORMAT in our database: 
`SELECT TABLE_SCHEMA,TABLE_NAME,ROW_FORMAT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'moodle';`
<img src ='Screenshots/check_ROW_FORMAT.png'>

So, as we can see, this format does not suit us. **We need a Dynamic**, according to amazon's documentation: https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.MySQL.html#CHAP_Source.MySQL.CustomerManaged.

> These actions can be dangerous for the contents of the database! Before you do them, make sure you have a backup.

**For a single table, you need to run the following:**
```ALTER TABLE `our_table` ROW_FORMAT=DYNAMIC;```

**But what if there are thousands of such tables?**
>Just use this script: `change_row_format.sh`


### Congratulations! You have successfully change ROW_FORMAT in all tables in your database. Now, you can create new dump and migrate/restoring a MySQL database from a dump.


## _Useful links:_
- fq
 