mlin.net_playbooks
==================

GCE instance bootstrap:

```{bash}
sudo -i

passwd mlin

apt-get install libpam-google-authenticator -y
GA_DEB_FN="libpam-google-authenticator_20130529-2_amd64.deb"
wget http://http.us.debian.org/debian/pool/main/g/google-authenticator/${GA_DEB_FN} -O /tmp/${GA_DEB_FN}
dpkg -i /tmp/${GA_DEB_FN}
su -l mlin -c google-authenticator

echo auth required pam_google_authenticator.so >> /etc/pam.d/sshd
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
echo AllowUsers mlin >> /etc/ssh/sshd_config

add-apt-repository ppa:ansible/ansible -y
apt-get update
apt-get install git ansible -y

ansible-pull -d /etc/mlin.net_playbooks -U https://github.com/mlin/mlin.net_playbooks.git -i 'localhost,' -v
service ssh restart
```

Access: `mosh mlin@hostname` or x2go

Execute playbook: `sudo /etc/mlin.net_playbooks/execute`

Update beacon: `sudo ansible-playbook -i localhost, /etc/mlin.net_playbooks/run_role.yml -e "ROLE=narcissome-beacon"`

Loggly setup ([linux](https://mlin.loggly.com/sources/setup/linux) [nginx](https://mlin.loggly.com/sources/setup/nginx) [file](https://mlin.loggly.com/sources/setup/file_monitoring_linux))

