$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$fileLocation = Join-Path $toolsDir 'KeeperSetup32.exe'
$fileLocation64 = Join-Path $toolsDir 'KeeperSetup64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  file			= $fileLocation
  file64		= $fileLocation64
  softwareName  = 'keeper-password-manager*' 
  checksum      = 'FD03C5914AC9659298FA3F55086486492A925F524EFF08769DE35C35933F01DF'
  checksumType  = 'sha256'
  checksum64    = '3F1720F2F9C8DC7A0EC13B68546F0EADE1D576FADEDB7FBE3E8D6E7F6A139255'
  checksumType64= 'sha256'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
  validExitCodes= @(0, 3010, 1641)
 
}

Install-ChocolateyInstallPackage @packageArgs 