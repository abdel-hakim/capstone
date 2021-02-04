# Cloud DevOps Engineer Nanodegree-Capstone Project.

## Udacity
MyRepo: https://github.com/abdel-hakim/capstone.git
----------------------------------------------------
1. Create the aws EC2 instance where jenkins is going to run. Create the EC2 instance Ubuntu Server.
2. Add security rule for ssh.
3. Add security rule for custom tpc in port 8080.
4. Installing Jenkins for Ubuntu.
5. Update the repositories
sudo apt update
6.  Install java 8
sudo apt install openjdk-8-jdk
sudo apt install openjdk-11-jdk
Test that it was correctly done:
java -version

7.  Install jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
8. Configure Jenkins
9. Go to the Jenkins UI http://your_server_ip_or_domain:8080.
10. Get the passwords by running:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
- Use the password and continue the set up
11. Follow this to install blueocean: https://www.jenkins.io/doc/book/blueocean/getting-started/#on-an-existing-jenkins-instance
12. Restart jenkins
sudo systemctl restart jenkins
13. Installing aws cli
5.1 Install unzip (only if it is not installed)
sudo apt install unzip
14. Install glibc (only if it is not installed)
sudo apt install glibc-source
15. Install aws cli version 2. :
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
- or Please follow the steps in this guide to install it:
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

16. Configure the aws cli
Set the aws credentials in the ubuntu user. Run:
aws configure
⚠️ This credentials are only available to the ubuntu user and not by jenkins, that is why we need to use the next aws plugin and set credentials for jenkins.

17. Install the aws plugin in Jenkins :



Restart jenkins
sudo systemctl restart jenkins

18. Create the aws credentials in jenkins.

19. Installing eksctl

Download and extract the latest release of eksctl with the following command.

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

Move the extracted binary to /usr/local/bin.

sudo mv /tmp/eksctl /usr/local/bin

Test that your installation was successful with the following command.

eksctl version

20. Installing kubectl

Kubernetes 1.18:

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
sudo mv ./kubectl /usr/local/bin

or check here ==> https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

21. Installing docker
You can use this tutorial for linux ubuntu https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

22. Create in Jenkins the credentials for Docker
If you need to add a user to the docker group that you’re not logged in as, declare that username explicitly using:
sudo usermod -aG docker jenkins
23. Restart jenkins so that the changes are put in place :
sudo systemctl restart jenkins
