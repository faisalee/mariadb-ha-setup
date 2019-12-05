clear

echo "Stopping Contianers..."
docker-compose stop

echo "Removing Contianers..."
docker container rm govtech_server1_1
docker container rm govtech_server2_1
docker container rm govtech_server3_1
docker container rm govtech_server4_1
docker container rm govtech_maxscale1_1
docker container rm govtech_maxscale2_1

echo "Rebuilding Contianers..."
docker-compose up -d
sleep 5
echo "log_bin = mariadb-bin" >> server1.cnf
echo "log_bin = mariadb-bin" >> server2.cnf
echo "log_bin = mariadb-bin" >> server3.cnf
echo "log_bin = mariadb-bin" >> server4.cnf

docker-compose restart
sleep 5

docker exec -it govtech_server1_1 sh /go.sh Primary-Node
docker exec -it govtech_server2_1 sh /go.sh Secondary-Node-1
docker exec -it govtech_server3_1 sh /go.sh Secondary-Node-2
docker exec -it govtech_server4_1 sh /go.sh Secondary-Node-3
