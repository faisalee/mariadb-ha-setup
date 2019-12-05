Host=$1
retryCount=0;
until [ ${retryCount} -gt 5 ]
do
   response=$(mysql -uroot -e "show processlist")
   retVal=$?
   if [ ${retVal} -eq 0 ]
   then
      echo "MariaDB service started on ${Host}!"
      echo ""
      break
   else
      retryCount=$((retryCount+1))
      echo "MariaDB service not yet available on ${Host}, retrying in 1 second..."
      echo ""
      sleep 1
   fi
done

response=$(mysql -uroot < /secondary.sql)
retVal=$?

if [ ${retVal} -eq 0 ]
then
   echo ""
   echo "------------------------------------"
   echo "Slave Node Configuration Successful!"
   echo "-------------------------------------"
   echo ""
else
   echo ""
   echo "********************************"
   echo "Slave Node Configuration Failed!"
   echo "********************************"
   echo ""
fi
