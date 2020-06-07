#Created by 60dhi; Handle with Care and use at your own risk
#Displays SSID along with the Saved Passwords of the WiFi profiles stored within Windows System
#The script user must be an administrator in order for this to work


#extract all profiles
$profileDetails = (netsh wlan show profiles | Select-String -Pattern "All User Profile")

foreach($item in $profileDetails)
	{
		#storing profile name in the array after stripping colon
		$profileName = ($item -split":")[1]
			#for each loop
			foreach($name in $profileName) 	 
				{ 
					#removing extra space from the obtained profile name
					$name = ($name -split" ")[-1] 
					#extracting stored profile details for an SSID or a profile
					$wifiDetails = netsh wlan show profiles name=$name key=clear
					#extracting ssid
					$ssid = (($wifiDetails | Select-String -Pattern  'SSID name' ) -split ":" )[1] -replace '"'
					#extracting password in clear text
					$passphrase = (($wifiDetails | Select-String -Pattern  'Key Content' ) -split ":" )[1] -replace '"'
					#checking is passphrase and ssid is not blank
					if ($ssid -and $passphrase)
						{
							echo "$ssid : $passphrase"
						}
			
				}
	
	}
