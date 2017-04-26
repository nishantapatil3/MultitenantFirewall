#install essential packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev libdnet -y
#install daq and snort
mkdir ~/snort_src
cd ~/snort_src
#daq
wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
tar xvfz daq-2.0.6.tar.gz
cd daq-2.0.6
./configure && make && sudo make install
#snort
wget https://www.snort.org/downloads/snort/snort-2.9.9.0.tar.gz
tar xvfz snort-2.9.9.0.tar.gz
cd snort-2.9.9.0
./configure --enable-sourcefire && make && sudo make install
#updating the shared libraries
sudo ldconfig
#setting up for Intrusion Prevention
sudo mkdir /etc/snort
sudo mkdir /etc/snort/rules
sudo mkdir /usr/local/lib/snort_dynamicrules
sudo mkdir /var/log/snort
sudo touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules /etc/snort/rules/local.rules
sudo chmod -R 5775 /etc/snort
sudo chmod -R 5775 /var/log/snort
sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules
sudo chown -R snort:snort /etc/snort
sudo chown -R snort:snort /var/log/snort
sudo chown -R snort:snort /usr/local/lib/snort_dynamicrules
sudo cp ~/snort-2.9.9.0/etc/*.conf* /etc/snort
sudo cp ~/snort-2.9.9.0/etc/*.map /etc/snort
wget https://www.snort.org/rules/community -O ~/community.tar.gz
sudo tar -xvf ~/community.tar.gz -C ~/
sudo cp ~/community-rules/* /etc/snort/rules
sudo sed -i 's/include \$RULE\_PATH/#include \$RULE\_PATH/' /etc/snort/snort.conf
