# docker_virtual_host
This is simple script for update virtual host ip in local machine. For use it you must run script as root and change your template for /etc/hosts/ . Be carefull when you run this script file /etc/hosts will be truncate and recreate again.I added this script to cron task for root user:
#crontab -e
@reboot  sh /path/to/script
