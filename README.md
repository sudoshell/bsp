# Burp-Suite-Pro

# Burp Suite Professional Installation steps for Windows
	--> Downloaded [windows.ps1](./windows.ps1) file to C:\Burp.
		Make new directory "Burp" in C Drive for faster access.
	--> Open Powershell in the created directory and execute below command to set Script Execution Policy.
		Set-ExecutionPolicy -ExecutionPolicy bypass -Scope process
	--> Now Execute Windows_Setup.ps1 file in Powershell to Complete Installation.
		./Windows_Setup.ps1
    --> Right click on `burpsuitepro.bat` and select to Send to Desktop Create Shortcut
	--> For Start Menu Entry, copy the created file in Desktop to 
		C:\ProgramData\Microsoft\Windows\Start Menu\Programs\
	

# Burp Suite Professional Installation steps for Kali-Linux 
	curl -sL https://github.com/sudoshell/bsp/raw/a960cf1a/linux.sh  | sudo bash

# Burp Suite Pro Activation Steps 
	1. Modify License String like "license to xxxxxxxx"
	2. Copy License key from loader.jar(Keygenerator) and paste in Burp Suite Pro and click Next.
	3. Select Manual Activation Option on your bottom Right in Burp Suite Pro.
	4. Copy License Request from BurpSuite_Pro and paste in Keygenerator.
	5. Copy license response from Keygenerator and paste in Burp Suite Pro, then next and Done.

# Executing Burp Suite Profession after Activation
	--> Windows :-: You can start Burp Suite Professional from Start Menu.
	--> Kali Linux :-: You can start Burp Suite Professional from Start Menu.
