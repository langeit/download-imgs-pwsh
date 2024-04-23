Clear-Host
Write-Host "========================================================="
Write-Host "==                   Image Downloader                  =="
Write-Host "========================================================="

$URL = Read-Host -Prompt "Enter URL "
$PIC = Read-Host -Prompt 'Enter number of images '
$GAL = Read-Host -Prompt "Enter Gallery Name"

# You can even leave out the path paremeter label
$Dest = "tmp"
New-Item $Dest -Type Directory


for ($var = 1; $var -le $PIC; $var++) {


# Download file
$FileName0 = $URL+$Var+".jpg"
$FileName1 = $URL+$Var+".png"

Try {
	#Download JPG files
	Invoke-WebRequest -Uri $FileName0 -OutFile $Dest -ErrorAction Stop
} Catch { 
	$StatusCode = [int]$_.Exception.Response.StatusCode

	if ($StatusCode -eq 404) {
		#Download PNG files
		Invoke-WebRequest -Uri $FileName1 -OutFile $Dest
	}
}
}
# All files downloades
Write-Host All files downloaded.

# Rename folder
Rename-Item -Path "$Dest" -NewName "$GAL"
