$commit = git log -1 --pretty=%B
Write-Host "My commit was: $commit"
$null = $commit[0] -match '(?<package>(?<=\[).+?(?=\]))'
Write-Host $matches.package
Write-Host "##vso[task.setVariable variable=ChangedNuspec]$($matches.package)"