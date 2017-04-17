#! /usr/bin/sudo /bin/bash
# Copyright (c) 2015 by RightScale Inc., all rights reserved worldwide

# Check if git is installed. If not, we'll install it below.
command -v git >/dev/null 2>&1 || { gitservice="git"; }

os_check=`uname -a | grep -i ubuntu`
if [ $? -eq 0 ]
then
  # We're on an ubuntu server
  webservice="apache2"
  apt-get install -y ${webservice} ${gitservice}
  www_dir="/var/www"
else
  # We'll assume we're on centos/redhat, etc
  webservice="httpd"
  yum install -y ${webservice} ${gitservice}
  www_dir="/var/www/html"
fi

# get the application package from the specified GIT repo
clone_dir=`mktemp -d`
git clone $APPLICATION_REPO ${clone_dir}

# Drop in the HTML5 application package (attached to the rightscript)
cp -r ${clone_dir}/application/* "${www_dir}"

#rm -rf ${clone_dir}

echo ">>> Installed apache and HTML5 website"

service ${webservice} restart
