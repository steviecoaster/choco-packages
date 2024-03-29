$testPath =  $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$functionpath = "$(Split-Path -Parent $testPath)\build\Get-ChocolateyPackageMetaData.ps1"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


. $functionpath

$package = Get-ChocolateyPackageMetaData -NuspecFile "$env:Nuspec"
$installScript = Get-Content "$($env:NuspecDirectory)\tools\chocolateyInstall.ps1"

Describe "Packages should contain certain information" {

$Urls = $installScript -match 'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/\/=]*)'
If($Urls) {
    It "Binary download urls " {

        $Urls | ForEach-Object {

            $null = $_ -match 'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/\/=]*)'
            $result = Invoke-WebRequest $($matches.0) -UseBasicParsing
            $result.StatusCode | Should -Be '200'
        
        }
    
    }

}



    It "Has a proper semver version" {
       
        $package.Version | Should -Not -BeNullOrEmpty
        $package.Version | Should -Match '^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$'

    }

    It "Has a description" {
        $package.Description | Should -Not -BeNullOrEmpty

    }

    It "Has an author" {
        $package.Authors | Should -Not -BeNullOrEmpty

    }

    It "Has a Project URL" {
        $package.ProjectUrl | Should -Not -BeNullOrEmpty
    }

    It "Project URL should resolve" {
        $result = Invoke-WebRequest "$($package.ProjectUrl)/tree/master/$($package.id)" -UseBasicParsing
        $result.StatusCode | Should -Be '200'
    }
}
