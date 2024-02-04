#!/bin/bash
OR='\e[38;5;202m'
GR='\e[32m'
NL='\e[0m'
WH='\e[97m'
BL='\e[34m'

# # Check if Java JDK 19 is installed
# if ! command -v javac >/dev/null 2>&1; then
#     echo "Java JDK 19 is not installed, installing"
#     mkdir -p /usr/local/java
#     mkdir -p /usr/local/java/jdk19
#     curl -L https://download.oracle.com/java/19/archive/jdk-19_linux-x64_bin.tar.gz -o jdk19.tar.gz
#     tar -xf jdk19.tar.gz -C /usr/local/java/jdk19 --strip-components=1
#     rm jdk19.tar.gz
#     echo "export JAVA_HOME=/usr/local/java/jdk19" | sudo tee -a /etc/environment
#     echo "export PATH=$PATH:$JAVA_HOME/bin" | sudo tee -a /etc/environment   #by @ricardev2023
#     sudo update-alternatives --install /usr/bin/java java /usr/local/java/jdk19/bin/java 1
#     sudo update-alternatives --install /usr/bin/javac javac /usr/local/java/jdk19/bin/javac 1
#     source /etc/profile
#     echo "Java JDK 19 downloaded and installed successfully"
# fi

# # Check if Java JRE 8 is installed
# if ! command -v java >/dev/null 2>&1; then
#     jre8_url=https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247938_0ae14417abb444ebb02b9815e2103550
#     sudo mkdir -p /usr/local/java/jre8
#     sudo curl -L -o /usr/local/java/jre8/jre8.tar.gz $jre8_url
#     sudo tar -xzf /usr/local/java/jre8/jre8.tar.gz -C /usr/local/java/jre8
#     sudo rm /usr/local/java/jre8/jre8.tar.gz
#     sudo update-alternatives --install /usr/bin/java java /usr/local/java/jre8/jre1.8.0_361/bin/java 1
#     sudo update-alternatives --install /usr/bin/javac javac /usr/local/java/jre8/jre1.8.0_361/bin/javac 1
#     sudo update-alternatives --set java /usr/local/java/jre8/jre1.8.0_361/bin/java 1
#     sudo update-alternatives --set javac /usr/local/java/jre8/jre1.8.0_361/bin/javac 1
#     echo "Java JRE 8 downloaded and installed successfully"
# fi

# Download Burp Suite Profesional Latet Version
echo 'Downloading Burp Suite Professional ....'
sudo mkdir -p /usr/share/burpsuite
cd /usr/share/burpsuite/
Link="https://github.com/sudoshell/bsp/raw/main/loader.jar"
sudo wget -c "$Link" -O loader.jar --quiet --show-progress
html=$(curl -s https://portswigger.net/burp/releases)
version=$(echo $html | grep -Po '(?<=/burp/releases/professional-community-)[0-9]+\-[0-9]+\-[0-9]+' | head -n 1)
Link="https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar"
echo $version
wget -c "$Link" -O burpsuite_pro.jar --quiet --show-progress
sleep 2
# Execute Burp Suite Professional with Keyloader
echo 'Executing Burp Suite Professional with Keyloader'
sudo echo "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/burpsuite_pro.jar" > burpsuitepro.sh
sudo chmod 755 burpsuitepro.sh
# execute Keygenerator
echo 'Starting Keygenerator'
java -jar loader.jar
echo 'Creating Desktop Entries'
cd /usr/share/applications/
sudo wget "https://github.com/sudoshell/bsp/raw/master/burp.desktop" -O burp-professional.desktop --quiet --show-progress
