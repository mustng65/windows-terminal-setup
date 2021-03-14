
function Set-ProfileProperty {
    param (
        $item,
        [string] $prop,
        $value
    )
    if ($item | Get-Member $prop) {
        $item."$prop" = $value
    }
    else {
        $item | Add-Member -Name $prop -Value $value -MemberType NoteProperty
    }


}



$rootPath = Get-ChildItem "$($env:USERPROFILE)\AppData\Local\Packages" -Filter "Microsoft.WindowsTerminal*"

$settingPath = "$rootPath\LocalState\settings.json"
$configFile = (Get-Content $settingPath) -replace '^\s*//.*' | Out-String | ConvertFrom-Json

foreach ($item in $configFile.profiles) {
    $item.name
    Set-ProfileProperty $item "acrylicOpacity" 0.75

}

$configFile | ConvertTo-Json -Depth 20 | Out-File c:\temp\wt_settings.json -Force

