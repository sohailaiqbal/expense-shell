dnf install nginx -y
cp expense.conf /etc/nginx/default.d/expense.conf
systemctl start nginx
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
systemctl enable nginx
systemctl restart nginx
