apt update
apt install nginx -y
cat <<EOF > /var/www/html/index.html
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>RUSLAN Serdiuk</title>
</head>
<body>
    <h1>DevOps Kharkiv</h1>
    <p>We have just configured our Nginx web server on Ubuntu Server!</p>
</body>
</html>
EOF
sed -i 's/server_name _;/server_name serdiukruslan.org;/' /etc/nginx/sites-enabled/default
service nginx restart