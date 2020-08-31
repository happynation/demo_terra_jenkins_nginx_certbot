# Configure Jenkins behind Nginx reverse proxy and Let’s Encrypt SSL
![Ansible](/images/cool-jenkins.png)

___


Let’s Encrypt is a Certificate Authority (CA) that provides an easy way to obtain and install free TLS/SSL certificates, thereby enabling encrypted HTTPS on web servers. It simplifies the process by providing a software client, Certbot, that attempts to automate most (if not all) of the required steps.

___

 ### Step 1 — Provision Jenkins server and Nginx with Terraform
 ### Step 2 — Installing Certbot
 First, add the repository:

```
sudo add-apt-repository ppa:certbot/certbot
```
Install Certbot’s Nginx package with apt:

```
sudo apt install python-certbot-nginx
```
### Step 3 — Confirming Route53, create A record
### Step 4 — Confirming Nginx’s Configuration
Next, we will create an Nginx server block file. As an example, we will refer to this file as example.com, although you may find it helpful to give yours a more descriptive name.
```
sudo nano /etc/nginx/sites-available/example.com
```

```
server {
    listen 80;

    server_name example.com;

    location / {
        proxy_pass http://localhost:8080;
    }
}
```
When you’re finished, save and close the file.

Next, enable the new configuration by creating a symbolic link to the sites-enabled directory.

```
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
```
Go ahead and restart the Nginx service:
```
sudo systemctl restart nginx
```
### Step 5 — Obtaining an SSL Certificate
```
sudo certbot --nginx -d example.com
```
Your certificates are downloaded, installed, and loaded. Try reloading your website using https:// and notice your browser’s security indicator. It should indicate that the site is properly secured, usually with a green lock icon.

 