#!/bin/bash

# Exit on error
set -e

echo "🔹 Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "🔹 Installing Java (required for Jenkins)..."
sudo apt install -y fontconfig openjdk-17-jre

echo "🔹 Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "🔹 Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔹 Updating package list..."
sudo apt update -y

echo "🔹 Installing Jenkins..."
sudo apt install -y jenkins

echo "🔹 Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "✅ Jenkins installation completed!"
echo "🔹 Jenkins is running on: http://<your-server-ip>:8080"
echo "🔹 To get initial admin password, run:"
echo "    sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
