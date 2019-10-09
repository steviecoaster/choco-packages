$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://gallery.technet.microsoft.com/Driver-Tool-Automate-9ddcc010/file/224244/1/Driver%20Automation%20Tool.zip' # download url, HTTPS preferred

$zipArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$toolsDir\dat"
  Url           = $url
}

Install-ChocolateyZipPackage @zipArgs


$fileLocation = Join-Path "$toolsDir\dat" "DriverAutomationToolSetup.exe"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'driverautomationtool*'
  checksum      = '83A6A69B575E82C4F06EBB3B5F651C901CF1AECFCBEF2BA73C8C09CB2A886981'
  checksumType  = 'sha256'
  silentArgs    = "/exenoui /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs 