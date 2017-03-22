$Folder = "c:\unit4cloud\autoXPinstall"		# Folder to save XPs to
$Install = 'Y' # Install Y/N?  If N, XPs are just downloaded. 

$URI = "https://abwupdates.agresso.com/updates.aspx?r1dim_value=600&product_area=EXP"


$HTML = Invoke-WebRequest -Uri $URI
$Links = @($HTML.Links.href | Where{ $_ -like 'UpdateDetails*' } ).replace("UpdateDetails.aspx","https://abwupdates.agresso.com/DownloadFile2.aspx")

$date = (Get-Date -format yyyyMMddHHmmss)

$message = ""

# Unzip function

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

New-Item $Folder -type directory

foreach ($Link in $Links)
{
    $index1 = $Link.IndexOf("dim_value") + 10
    $index2 = $Link.IndexOf("&amp;r1dim_value")
    $Filename = $Link.Substring($index1,($index2-$index1))
    $Zipfilename = $Filename + ".zip"
    $output = $Folder + "\" + $Zipfilename
    $start_time = Get-Date
    $message = "DOWNLOADING " + $Link + " to " + $output + "`n"
    Invoke-WebRequest -Uri $Link -OutFile $output
    If ($Install = 'Y')
    {
        $message = $message + "UNZIPPING " + $output + " to " + $Folder + "\" + $Filename + "`n"
        Unzip $output ($Folder + "\" + $Filename)
        $msifiles = Get-ChildItem -Path ($Folder + "\" + $Filename) -Filter *.msi | % { $_.FullName } 
        foreach ($msifile in $msifiles)
        {
            $message = $message + "INSTALLING " + $msifile + "`n"
            $args = "/i " + '"' + $msifile + '"' + " /quiet /l*v " + '"' + $Folder + "\" + $Filename + "\" + $date + "install.log" + '"'
            start-process msiexec.exe -ArgumentList $args -Wait
        }
    }  
}

write-host "Finished."

