# wan_ip_watchdog
Simple watchdog for wan ip changes, works great on a raspberry pi.

This is a super simple script that will check if your outside ip has changed via checkip.dyndns.org.  It requires ssmtp, but could be easily modified to use any sendemail type utility.

sSMTP setup:

sudo apt-get install ssmtp

sudo vi /etc/ssmtp/ssmtp.conf

Change the following configuration file to suite your needs:

root=myemailaddress@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=mygmailusername
AuthPass=mypassword
UseSTARTTLS=YES


