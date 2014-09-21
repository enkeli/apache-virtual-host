#!/bin/bash

# Create new virtual hosts for apache server
#
# @author Gabriel Vargas <angel.wrt@gmail.com>

if [ $# -lt 2 ]
  then
    printf "You must pass 2 arguments: \n\t1 the name of the new virtual host \n\t2 email of the admin of that virtual host\n";
    exit 1;
   else
    name="$1";
    email="$2"
fi

if [ $# -gt 2 ]
  then
    ip="$3";
  else
    ip="127.0.1.1"
fi

if [ $# -gt 3 ]
  then
    prefix="$4/";
    domainname=".$4";
  else
    prefix="";
    domainname="";
fi

echo "We need to run this in sudo mode:"

sudo echo "yay";

#first make our requests head to $ip
newhost="\n# Virtual host created with <https://github.com/Angel-Gabriel/apache-virtual-host>";
newhost+="\n$ip\t$name$domainname";

echo -e $newhost | sudo tee -a /etc/hosts >/dev/null;


#then create new file structure for the vhost $name
path="/var/www/$prefix$name";

sudo mkdir -p "$path/public_html";
sudo mkdir -p "$path/logs";


#grant perms on it
sudo chown -R $USER:$USER "$path";

#create a demo page
index="<html>\n\t<head>\n\t\t<title>Welcome to $name$domainname!</title>\n\t</head>\n\t<body>\n\t\t<h1>Success!  The $name$domainname virtual host is working!</h1>\n\t</body>\n</html>";

echo -e "$index" > "$path/public_html/index.html";

#Here we actually create the Apache virtual host config file
config="# Virtual host created with <https://github.com/Angel-Gabriel/apache-virtual-host>";
config="\n<VirtualHost *:80>\n\tServerName $name$domainname\n\tServerAdmin $email\n\tDocumentRoot $path/public_html\n\tErrorLog $path/logs/error.log\n\tCustomLog $path/logs/access.log combined\n</VirtualHost>";

echo -e "$config" | sudo tee -a "/etc/apache2/sites-available/$name$domainname.conf" > /dev/null;

#and we enable it
sudo a2ensite "$name$domainname.conf";

#just restart apache...
sudo service apache2 restart;

echo "Success! now point your browser to $name$domainname and test your new virtual host."



 
