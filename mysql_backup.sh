# Backup storage directory 
backupfolder=/var/backups
# Notification email address 
recipient_email=<username@mail.com>
# MySQL user
user=<user_name>
# MySQL password
password=<password>
#Mysql HOST
localhost=<hostname>
#MYSQL port 
port=<port>
# Number of days to store the backup 
# Number of days to store the backup 
keep_day=30 
sqlfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M-%S).zip 
# Create a backup 
sudo mysqldump --single-transaction --column-statistics=0   -u $user -p$password -h$localhost --port$port databasename > $sqlfile 
if [ $? == 0 ]; then
  echo 'Sql dump created' 
else
  echo 'mysqldump return non-zero code' | mailx -s 'No backup was created!' $recipient_email  
  exit 
fi 
# Compress backup 
zip $zipfile $sqlfile 
if [ $? == 0 ]; then
  echo 'The backup was successfully compressed' 
else
  echo 'Error compressing backup' | mailx -s 'Backup was not created!' $recipient_email 
  exit 
fi 
rm $sqlfile 
echo $zipfile | mailx -s 'Backup was successfully created' $recipient_email 
# Delete old backups 
find $backupfolder -mtime +$keep_day -delete
