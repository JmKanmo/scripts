<!-- DB 이중화 master <-> slave 가이드 -->

[참조 블로그] 
https://huisam.tistory.com/entry/mysql-replication?category=689280


1. master, slave 폴더 생성 
   각 폴더마다 my.cnf, DockerFile 생성 
   파일 내용은 폴더 참조 


2. docker-compose.yml 파일 생성 
   포트, username, password 각각 기입 
   docker-compose 파일 up 


3. git bash를 통해 아래 명령어 입력 및 master, slave ipv4 address 확인 
    $ docker network ls 
    $ docker inspect ${컨테이너 주소}

<!-- master 에서 할 것 -->
4. mysql master 컨테이너 접속 한 뒤에 로그인 및 권한 명령어 입력 

    $ mysql -u root -p 
    $ mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%.example.com';
      실제로는 아래 명령어 입력 
    $ mysql> GRANT REPLICATION SLAVE ON *.* TO 'junmokang'@'%'
    $ mysql> flush privileges; 
    $ mysql> show master status; 
    이때, 출력되는 File (mysql-bin.00004) <- 파일명 확인 


5. slave 컨테이너 접속 뒤 로그인 및 아래 명령어 입력  
<!-- slave에서 할 것 -->

$ mysql -u root -p 

$ mysql> CHANGE MASTER TO MASTER_HOST='172.26.0.10', MASTER_USER='root', MASTER_PASSWORD='wnsah12', MASTER_LOG_FILE='mysql-bin.000009', MASTER_LOG_POS=0, GET_MASTER_PUBLIC_KEY=1;
MASTER_HOST, MASTER_USER, MASTER_PASSWORD, MASTER_LOG_FILE <- 이 변수들은 적절히 찾아서 입력할 것. MASTER_LOG_FILE은 위에 master에서 show master status; 입력햇을 때, FILE 명을 입력해준다. 

$ mysql> start slave; 
$ mysql> show slave status\G; 

아래 출력되는 정보에서  Slave_IO_Running, Slave_SQL_Running 정보가 Yes로 찍혀야 한다. 
오류가 있을 경우, Error 정보를 확인하도록 한다. 

*************************** 1. row ***************************
               Slave_IO_State: Waiting for source to send event
                  Master_Host: 172.25.0.3
                  Master_User: root
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000004
          Read_Master_Log_Pos: 549
               Relay_Log_File: mysql-relay-bin.000002
                Relay_Log_Pos: 765
        Relay_Master_Log_File: mysql-bin.000004
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 549
              Relay_Log_Space: 975
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 10
                  Master_UUID: 8bac731c-1cd9-11ed-82a0-0242ac190003
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Replica has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind:
      Last_IO_Error_Timestamp:
     Last_SQL_Error_Timestamp:
               Master_SSL_Crl:
           Master_SSL_Crlpath:
           Retrieved_Gtid_Set:
            Executed_Gtid_Set:
                Auto_Position: 0
         Replicate_Rewrite_DB:
                 Channel_Name:
           Master_TLS_Version:
       Master_public_key_path:
        Get_master_public_key: 1
            Network_Namespace:
1 row in set, 1 warning (0.00 sec)

ERROR:
No query specified



<!-- 마무리 -->

이제, master에서 DB 생성 및 테이블 생성 및 데이터 삽입 시에, slave에서 해당 정보 확인이 가능하다. 

