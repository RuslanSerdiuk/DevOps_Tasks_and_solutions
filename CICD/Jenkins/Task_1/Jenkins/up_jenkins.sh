# Setup Jenkins
    sudo apt-get update
    sudo apt-get install openjdk-8-jre

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
    sudo apt install openjdk-11-jdk -y

    sudo systemctl daemon-reload
    sudo systemctl start jenkins
    sudo systemctl status jenkins

# Setup_Docker
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    sudo usermod -a -G docker vagrant
	sudo usermod -a -G docker jenkins

# Generating ssh
    # ssh-keygen
    # sudo cat ~/.ssh/id_rsa
    # sudo cat ~/.ssh/id_rsa.pub
    # cd .ssh/
    # sudo cat id_rsa.pub > authorized_keys
    # sudo ip a

sudo ip a
sudo cat /var/lib/jenkins/secrets/initialAdminPassword