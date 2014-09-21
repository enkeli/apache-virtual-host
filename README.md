apache-virtual-host
===================

Automate the creation of new Apache's virtual hosts in Ubuntu

###Usage:

> subdomain|domain email [ip adress] [domain]

####Example with a subdomain:

```bash
./newVirtualHost.sh subdomain admin@mail.com 127.0.1.1 domain.com
```

This will create a new virtual host with domain subdomain.domain.com heading to /var/www/domain.com/subdomain/public_html


####Example with a domain:

```bash
./newVirtualHost.sh example.com admin@mail.com
```

This will create a new virtual host with domain example.com heading to /var/www/example.com/public_html
