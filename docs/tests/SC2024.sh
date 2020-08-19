##Patterns: SC2024

##Warning: SC2024
sudo echo 'export FOO=bar' >> /etc/profile

echo 'export FOO=bar' | sudo tee -a /etc/profile > /dev/null
