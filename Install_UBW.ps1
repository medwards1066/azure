$drive = 'E'
$date = (Get-Date -format yyyyMMddHHmmss)

$cmd = ('"' + $drive + ':\unit4 business world\setup.exe"') 
$arg = ('/S /V"INSTALLLEVEL=150 INSTALL_IIS=1 /qn /lv*x c:\unit4cloud\ubwinstall_' + $date + '.log"')

#write-host $cmd
#write-host $arg



start-process $cmd -argumentlist $arg
