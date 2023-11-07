echo -e "\e[36m Installing nginx \e[0m"
dnf install nginx -y &>>/tmp/expense.log

echo -e "\e[36m Copying expense config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log

echo -e "\e[36m Clean old nginx content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log

echo -e "\e[36m Download front application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log

echo -e "\e[36m Extract downloaded application content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/expense.log

echo -e "\e[36m Starting nginx service \e[0m"
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx &>>/tmp/expense.log
