If(!(Get-Module Pester)){
    Install-Module -Name Pester -SkipPublisherCheck -Force -RequiredVersion 4.7.1
}

Invoke-Pester ./tests/package.tests.ps1 -OutputFile "$($env:Build_ArtifactStagingDirectory)\$($env:Package).xml" -OutputFormat 'NUnitXml'

