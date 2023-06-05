# TASK 3.[1-4]-[NETWORK]:earth_americas:

> ## :bangbang: [TASK :three:.:one:](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.1/Task%203.1.pdf)


#### :one: I [created networks](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.1/Create.png) as shown in the example.

:two:Then I created such static addresses:
+ 10.96.17.10 for Client1
+ 10.96.17.20 for Client2
+ 10.96.17.100 for DHCP Server

:three: And I checked ping between clients
> :camera: Screenshots [**step 1**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.1/ste%D1%801.png)

:four: Next step I gave next static IP addresses in network Data Center:
+ 10.17.96.50 for Web Server 1
+ 10.17.96.100 for Web Server 2
+ 10.17.96.150 for DNS Server

:five: And I checked ping between servers too
> :camera: Screenshots [**step 2**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.1/ste%D1%802.png)

:six: For Client3 I changed from Ethernet to Wi-Fi module and gave next static IP address:
+ 192.168.0.27
+ Checked ping 192.168.0.1
> :camera: Screenshots [**step 3**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.1/ste%D1%803.png)
___
> ## :bangbang: [TASK :three:.:two:](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/Task%203.2.pdf)


:one: I connected the networks through the interfaces in the screenshot:![Start.png](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/Start.png)

:two: In result separation main network on the subnets, was assigned next addresses interface's on the routers:
> ### *ISP1:*
>> + GE0/0 - 10.96.17.1
>> + GE1/0 - 27.10.96.1
>> + GE2/0 - 27.10.96.65

> ### *ISP2:*
>> + GE0/0 - 27.10.96.193
>> + GE1/0 - 27.10.96.2
>> + GE3/0 - 27.10.96.129

> ### *ISP3:*
>> + GE0/0 - 10.17.96.1
>> + GE2/0 - 27.10.96.66
>> + GE3/0 - 27.10.96.130

> :camera: Screenshots [**steps 2**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/Step2.png)

### :exclamation: Configuring VLAN in Data Center :wrench: :hammer:

:three: I checked ping between my servers in Data Center
> :camera: Screenshots [**step 3**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/ste%D1%803.png)

:four: Next step I changed subnet mask from 255.255.255.0 to 255.255.255.192 as was in task and again checked ping between my servers

:warning: **But ping didn't work because our IP addresses and masks on servers in different subnet** :warning:
> :camera: Screenshots [**step 4**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/ste%D1%804.png)


:five: I have created yet VLAN and  assigned their on ports:
+ FE0/2 – VLAN2
+ FE0/3 – VLAN3
+ FE0/4 – VLAN4

:warning: **But ping hasn't work yet. Because our Servers still have different IP addresses and masks in subnet and hasn't seen each other + turned off "trunk" on the port FE0/1 on the switch Data Center** :warning:
> :camera: Screenshots [**step 5**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/ste%D1%807After_VLAN.png)

:six: Next I turned on "Trunk" on the port FE0/1 on the switch Data Center and deleted static IP address on port GE0/0 the router ISP3

:seven: I moved in mode CLI on the router ISP3 and created three subinterface and configured their like show on the screenshot below:
> :camera: Screenshots [**step 6**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/ste%D1%8012_VLAN_PING.png)

:eight: Last what I did, that assigned default gateways on the WS1, WS2 and DNS Server like IP addresses on the new subinterfaces. Done! Our VLANs work! :fire:
> :camera: Screenshots [**step 7**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.2/ste%D1%8013_VLAN_WORK.png)
___

> ## :bangbang: [TASK :three:.:three:](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.3/Task%203.3.pdf)

:warning: Before start, I returned ports FE0/2, FE0/3 and FE0/4 to VLAN1 on the switch subnet Data Center and returned mask subnet to 255.255.255.0 :point_up: :ok_hand:

:one: After config routes on the routers, our table show so:
> ### *ISP1:*
>> + 10.17.96.0/24 via 27.10.96.66
>> + 27.10.96.192/26 via 27.10.96.2

> ### *ISP2:*
>> + 10.17.96.0/24 via 27.10.96.130
>> + 10.96.17.0/24 via 27.10.96.1

> ### *ISP3:*
>> + 10.96.17.0/24 via 27.10.96.65
>> + 27.10.96.192/26 via 27.10.96.129
> ### Home Router:
>> + Add default route to Router ISP2

> :camera: Screenshots commands **ping** and **tracert** [**chek1**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.3/Ping.png), [**check2**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Vagrant_and_Network/Vagrant_and_Network/Packet_Tracer/Task%203.3/Ping2.png), [**check3**](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/Vagrant_and_Network/Vagrant_and_Network/Packet_Tracer/Task%203.3/Ping3.png). 
___

> ## :bangbang: [TASK :three:.:four:](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.4/Task%203.4.pdf)

:one: Here I [configured DHCP Server](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.4/Step1.png) 

:two: For work DNS, I assigned WS1 and WS2 domain names "domain1.com" and "domain2.com" and add their in the config DNS Server + turned on DNS. 
> Check screenshots [HERE](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.4/Step2.png)

:three: And last, I [added address DNS Server to config DHCP Servers](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.4/Step3.png) and updated config on the Clients1-2 (Begin, I changed from DHCP to Static IP, next returned again from Static IP to DHCP)

### See results my work [HERE](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/blob/main/Vagrant_and_Network/Packet_Tracer/Task%203.4/Step4.png) (sending ping from Client1-2 to the domain names "domain1.com" and "domain1.com" + command "tracert")

# ***THE END***