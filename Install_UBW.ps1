$drive = "E"

$cmd = ('"' + $drive + ':\unit4 business world\setup.exe"') 
$arg = ('/S /V"INSTALLLEVEL=150 INSTALL_IIS=1 /qn /lv*x c:\temp\abwinstall.txt"')

write-host $cmd
write-host $arg

start-process $cmd -argumentlist $arg
