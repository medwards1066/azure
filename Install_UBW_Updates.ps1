# Download Update File to c:\unit4cloud.
# Currently UBW2016UPDATE02.

$url = "https://abwupdates.agresso.com/ldownload/UBW2016UPDATE02.zip"
$output = "c:\unit4cloud\UBW2016UPDATE02.zip"
$start_time = Get-Date

Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output


# Unzip Update File

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip "c:\unit4cloud\UBW2016UPDATE02.zip" "c:\unit4cloud\UBW2016UPDATE02"


#Install 32 bit Update

msiexec /update 'C:\unit4cloud\UBW2016UPDATE02\UBW2016UPDATE02 (32-bit).msp' /quiet

#Install 64 bit Update

msiexec /update 'C:\unit4cloud\UBW2016UPDATE02\UBW2016UPDATE02 (64-bit).msp' /quiet
