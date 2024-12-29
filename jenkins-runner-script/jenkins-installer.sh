#!/bin/bash
# Install Java 17
echo "Installing Java 17..."
sudo apt-get update
yes | sudo apt install openjdk-17-jdk-headless
echo "Waiting for 30 seconds before installing the jenkins package..."
sleep 30
#!/bin/bash

echo "Removing Java 11 and Jenkins for a clean reinstall..."

# Stop Jenkins service if running
sudo systemctl stop jenkins
sudo systemctl disable jenkins

# Remove Jenkins
sudo apt-get purge -y jenkins
sudo rm -rf /var/lib/jenkins /var/log/jenkins /var/cache/jenkins

# Remove Java 11
sudo apt-get purge -y openjdk-11-jdk-headless openjdk-11-jre-headless
sudo apt-get autoremove -y
sudo apt-get autoclean

# Verify Java is removed
java -version || echo "Java removed successfully."

# Install Java 17
echo "Installing Java 17..."
sudo apt-get update
yes | sudo apt install openjdk-17-jdk-headless

# Verify Java installation
java -version

# Add Jenkins repository key
echo "Adding Jenkins repository..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list
sudo apt-get update

# Install Jenkins
echo "Installing Jenkins..."
yes | sudo apt-get install jenkins

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check Jenkins service status
sudo systemctl status jenkins

echo "Jenkins reinstallation complete. Access Jenkins at http://<your-server-ip>:8080"

sudo apt-get update
yes | sudo apt-get install jenkins
sleep 30
echo "Waiting for 30 seconds before installing the Terraform..."
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_386.zip
yes | sudo apt-get install unzip
unzip 'terraform*.zip'
sudo mv terraform /usr/local/bin/
