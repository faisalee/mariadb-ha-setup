RESET MASTER;
CREATE USER maxuser@'%' identified by 'password';
GRANT ALL ON *.* to maxuser@'%';

