log_file=/tmp/expense.log
color="\e[33m"

echo -e "\e[36m Installing nginx \e[0m"
dnf install nginx -y &>>$log_file
echo$?

echo -e "\e[36m Copying expense config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo$?

echo -e "\e[36m Clean old nginx content \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo$?

echo -e "\e[36m Download front application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo$?

echo -e "\e[36m Extract downloaded application content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$log_file
echo$?

echo -e "\e[36m Starting nginx service \e[0m"
systemctl enable nginx &>>$log_file
systemctl start nginx &>>$log_file
echo$?