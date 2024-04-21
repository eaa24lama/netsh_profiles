$filename='profiles.txt'

Echo 'Getting wlan profiles. Out-File: ' $filename

# Get the SSIDs from netsh, strip away everything else. See readme.txt for a link to regex explanation.
$profiles=(netsh.exe wlan show profiles) -match '\s{2,}:\s' -replace '.*:\s', ''

# Write date to the file (clears the old file).
Echo (date) | Out-File -FilePath $filename

# Go through all the SSIDs and include the plaintext password, append to file.
Foreach ($item in $profiles) {
	netsh.exe wlan show profile name=$item key=clear | Out-File -FilePath $filename -Append
}

Echo 'Done.'
