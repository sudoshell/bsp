# Set Wget Progress to Silent, Becuase it slows down Downloading by 50x
echo "Setting Wget Progress to Silent, Becuase it slows down Downloading by 50x`n"
$ProgressPreference = 'SilentlyContinue'

# Check JDK-18 or 19 Availability or Download JDK-18 or 19
$jdk19 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java(TM) SE Development Kit 19*"
if (!($jdk19)){
    echo "`t`tDownnloading Java JDK-19 ...."
    wget "https://download.oracle.com/java/19/archive/jdk-19_windows-x64_bin.exe" -O jdk-19.exe  
    echo "`n`t`tJDK-19 Downloaded, lets start the Installation process"
    start -wait jdk-19.exe
    rm jdk-19.exe
}else{
    echo "Required JDK-19 is Installed"
    $jdk19
}

# Check JRE-8 Availability or Download JRE-8
$jre8 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java 8 Update *"
if (!($jre8)){
    echo "`n`t`tDownloading Java JRE ...."
    wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247947_0ae14417abb444ebb02b9815e2103550" -O jre-8.exe
    echo "`n`t`tJRE-8 Downloaded, lets start the Installation process"
    start -wait jre-8.exe
    rm jre-8.exe
}else{
    echo "`n`nRequired JRE-8 is Installed`n"
    $jre8
}

# Downloading Burp Suite Professional
echo "`n`t`tDownloading Latest Burp Suite Professional ...."
$version = (Invoke-WebRequest -Uri "https://portswigger.net/burp/releases/community/latest" -UseBasicParsing).Links.href | Select-String -Pattern "product=pro&amp;version=*" | Select-Object -First 1 | ForEach-Object { [regex]::Match($_, '\d+\.\d+\.\d+').Value }
wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O "burpsuite_pro_v$version.jar"
echo "`nBurp Suite Professional is Downloaded.`n"

# Creating Burp.bat file with command for execution
$path = "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:`"$pwd\loader.jar`" -noverify -jar `"$pwd\burpsuite_pro_v$version.jar`""
$path | add-content -path burpsuitepro.bat
echo "`nBurp.bat file is created"

# Lets Activate Burp Suite Professional with keygenerator and Keyloader
echo "Reloading Environment Variables ...."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
echo "`n`nStarting Keygenerator ...."
start-process java.exe -argumentlist "-jar loader.jar"
