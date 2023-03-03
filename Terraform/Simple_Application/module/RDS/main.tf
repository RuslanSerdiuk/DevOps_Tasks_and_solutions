#======================================CREATE RDS=========================================#
  resource "aws_db_subnet_group" "database_subnet_group" {
    name       = "database_subnets"
    subnet_ids = [var.vpc_public_subnets_b_id, var.vpc_public_subnets_a_id]
    description = "Subnets for DB Instance"

    tags = {
      Name = "${var.name}My_DB_subnet_group"
    }
  }


  resource "aws_db_instance" "database" {
    db_subnet_group_name        = aws_db_subnet_group.database_subnet_group.name
    vpc_security_group_ids      = [var.security_group_database_id]
    allocated_storage           = var.db_allocated_storage
    engine                      = var.type_db
    engine_version              = var.version_db
    allow_major_version_upgrade = false
    instance_class              = var.db_instance_class
    db_name                     = var.database_name
    username                    = var.db_username
    password                    = var.db_password
    port                        = var.db_port
    publicly_accessible         = true
    skip_final_snapshot         = true
    multi_az                    = false
    identifier                  = var.db_identity
    tags = {
      name = "${var.name}_TF_database"
    }

    depends_on = [
      aws_db_subnet_group.database_subnet_group
    ]
  }


