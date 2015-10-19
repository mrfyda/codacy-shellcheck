##Patterns: SC2024

##Info: SC2024
sudo echo 'export FOO=bar' >> /etc/profile

echo 'export FOO=bar' | sudo tee -a /etc/profile > /dev/null
