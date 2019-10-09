$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'vs_isoshell.exe'

$url = 'https://download.microsoft.com/download/C/9/C/C9CA8400-20AA-4488-92A3-F3F6D978AD81/vs_isoshell.exe'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #only one of these: exe, msi, msu
  url           = $url
  softwareName  = 'VS2015.IsolatedShell*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = 'CBCD5FB989B26DC3AD89F2A6D7BA249F7EB863586321FCA3D75975410537CBF0'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  silentArgs    = "/Q /S /Log `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs 