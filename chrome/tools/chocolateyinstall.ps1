$ErrorActionPreference = 'Stop'; # stop on all errors

$packageArgs = @{
  packageName            = 'googlechrome'
  fileType               = 'MSI'
  url                    = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
  url64bit               = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
  checksum               = '9d0403e362629f4b7e51081723e85cb9831cbb2b76f409d5d57d9b4014d87d12'
  checksum64             = 'b714d0e46e7e029e2f0e174ceddf62043207d3f61584247199ae43c10a8b5d48'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/quiet /norestart /l `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0)
}

Install-ChocolateyPackage @packageArgs #