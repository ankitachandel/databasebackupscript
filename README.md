# databasebackupscript
How to Automate MySQL Database Backups in Linux using shell script
1>To set up this solution, we need to install postfix mailutils. In Ubuntu we can do this as follows:
sudo apt-get update 
sudo apt-get install mysql-client postfix mailutils -y 
2> Add  mysql_backup.sh file path /home/apple/script/mysql_backup.sh
3> set execute permission using chmod
sudo chmod 777 /home/apple/script/mysql_backup.sh
4> Add scheduling scirpt file using script will be executed every day at 1:00pm IST
sudo crontab -e
Then, add the script path to the end of the string
00 13 * * * /home/user/script/mysql_backup.sh
