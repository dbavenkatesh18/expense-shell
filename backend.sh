log_file=/tmp/expense.log


echo -e "\e[36m Disable the nodeJs \e[0m"
dnf module disable nodejs -y  &>>$log_file
if [ $? -eq 0 ]; then
echo "SUCCESS"
else
echo "FAILURE"
fi

echo -e "\e[36m Enable the nodeJs \e[0m"
dnf module enable nodejs:18 -y  &>>$log_file
if [ $? -eq 0 ]; then
echo "SUCCESS"
else
echo "FAILURE"
fi

echo -e "\e[36m Installing the Node JS \e[0m"
dnf install nodejs -y &>>$log_file
echo $?

echo -e "\e[36m Copying the backend.service file \e[0m"
cp backend.service /etc/systemd/system/backend.service  &>>$log_file
echo $?

echo -e "\e[36m creating the expense user \e[0m"
useradd expense &>>$log_file
echo $?

echo -e "\e[36m Creating the app directory \e[0m"
mkdir /app  &>>$log_file
echo $?

echo -e "\e[36m removing the old content \e[0m"
rm -rf /app/*  &>>$log_file
echo $?

echo -e "\e[36m Downloading the supporting files \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
echo $?

echo -e "\e[36m Unzipping the supporting files \e[0m"
cd /app
unzip /tmp/backend.zip &>>$log_file
echo $?


echo -e "\e[36m Installing dependencies \e[0m"
cd /app
npm install &>>$log_file
echo $?

echo -e "\e[36m Installing MYSQL  \e[0m"
dnf install mysql -y  &>>$log_file
echo $?

echo -e "\e[36m logging to mysql database \e[0m"
mysql -h mysql-dev.dba2devops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>$log_file
echo $?

echo -e "\e[36m Reload the Daemon service \e[0m"
systemctl daemon-reload &>>$log_file
echo $?

echo -e "\e[36m Enabling the service \e[0m"
systemctl enable backend  &>>$log_file
echo $?

echo -e "\e[36m Starting the service \e[0m"
systemctl start backend &>>$log_file
echo $?