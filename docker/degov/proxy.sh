#!/bin/bash

# set host ip from host-ip.data file
#hostip=$(cat host-ip.data)
# hostname=$(cat /var/lib/hyperv/.kvp_pool_3 | sed 's/\x0//g' | grep -o APC[[:digit:]]\*[[:alpha:]]\*\.it\.nrw\.de | head -1)
hostname=APC25407H.it.nrw.de
hostip=$hostname:80

# run as root?
if [ "$(id -u)" -ne 0 ]; then
    echo 'This script must be run with root privileges' >&2
    exit 1
fi

## set proxy in /etc/profile

#delete existing proxy settings
sed -i '/export proxy/d' /etc/profile
sed -i '/export http_proxy/d' /etc/profile
sed -i '/export https_proxy/d' /etc/profile
sed -i '/export HTTP_PROXY/d' /etc/profile
sed -i '/export HTTPS_PROXY/d' /etc/profile
sed -i '/export ftp_proxy/d' /etc/profile
sed -i '/export FTP_PROXY/d' /etc/profile
sed -i '/export no_proxy/d' /etc/profile

echo 'Setting up the proxy in /etc/profile' >&2
cat >> /etc/profile << EOF
export proxy="http://${hostip}"
export http_proxy=\$proxy
export https_proxy=\$proxy
export HTTP_PROXY=\$proxy
export HTTPS_PROXY=\$proxy
export ftp_proxy=\$proxy
export FTP_PROXY=\$proxy
export no_proxy="127.0.0.1,localhost,gitlab.it.nrw.de,lv.gitrepo.it.nrw.de,drupal,drupal2,drupal2.local,drupal3,drupal.two,drupal.three,dvwa"
EOF


## Set Proxy in etc/apt/apt.conf
touch /etc/apt/apt.conf
#Delete line matching proxy configuration
sed -i '/Acquire::http::Proxy/d' /etc/apt/apt.conf
sed -i '/Acquire::https::Proxy/d' /etc/apt/apt.conf
#Write new settings
echo 'Setting up the proxy in /etc/apt/apt.conf' >&2
cat >> /etc/apt/apt.conf << EOF
Acquire::http::Proxy "http://${hostip}";
Acquire::https::Proxy "http://${hostip}";
EOF

## Set Proxy for additional Software that uses the APT Proxy
touch /etc/apt/apt.conf.d/proxy.conf
#Delete line matching proxy configuration
sed -i '/Acquire::http::Proxy/d' /etc/apt/apt.conf.d/proxy.conf
sed -i '/Acquire::https::Proxy/d' /etc/apt/apt.conf.d/proxy.conf
#Write new settings
echo 'Setting up the proxy in /etc/apt/apt.conf.d/proxy.conf' >&2
cat >> /etc/apt/apt.conf.d/proxy.conf << EOF
Acquire::http::Proxy "http://${hostip}";
Acquire::https::Proxy "http://${hostip}";
EOF

## Set Proxy for Snap
# https://askubuntu.com/questions/764610/how-to-install-snap-packages-behind-web-proxy-on-ubuntu-16-04
#snap set system proxy.http="http://${hostip}"
#snap set system proxy.https="http://${hostip}"

## Set Proxy for sudo
#sed -i '/env_keep/d' /etc/sudoers

#echo 'Settings up the proxy in /etc/sudoers' >&2
#sed -i '/env_reset/a Defaults env_keep += "http_proxy https_proxy"' /etc/sudoers

## Set Proxy for docker in /etc/systemd/system/docker.service.d/http-proxy.conf
mkdir -p /etc/systemd/system/docker.service.d
touch /etc/systemd/system/docker.service.d/http-proxy.conf

#delete existing proxy settings
sed -i '/Service/d' /etc/systemd/system/docker.service.d/http-proxy.conf
sed -i '/Environment/d' /etc/systemd/system/docker.service.d/http-proxy.conf

echo 'Setting up the proxy in /etc/systemd/system/docker.service.d/http-proxy.conf' >&2
cat >> /etc/systemd/system/docker.service.d/http-proxy.conf << EOF
[Service]
Environment="HTTP_PROXY=http://${hostip}"
EOF

## Set proxy for chromium-browser in /etc/chromium-browser/default
#mkdir -p /etc/chromium-browser
#delete existing proxy settings
#sed -i '/CHROMIUM_FLAGS/d' /etc/chromium-browser/default

#echo 'Setting up the proxy in /etc/chromium-browser/default' >&2
#cat >> /etc/chromium-browser/default << EOF
#CHROMIUM_FLAGS="--proxy-server=http://${hostip} --proxy-bypass-list=127.0.0.1,localhost,gitlab.it.nrw.de,lv.gitrepo.it.nrw.de"
#EOF

##Set proxy for chromium-brwoser in ~/.chromium-browser.init (snap install)
#delete existing proxy settings
#sed -i '/CHROMIUM_FLAGS/d' /home/dev/.chromium-browser.init

#echo 'Setting up the proxy in /home/dev/.chromium-browser.init' >&2
#cat >> /home/dev/.chromium-browser.init << EOF
#CHROMIUM_FLAGS="--password-store=basic --proxy-server=http://${hostip} --proxy-bypass-list=127.0.0.1,localhost,gitlab.it.nrw.de,lv.gitrepo.it.nrw.de"
#EOF

source /etc/profile

