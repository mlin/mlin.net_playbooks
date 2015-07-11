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
