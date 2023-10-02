$clipboardText = Get-Clipboard

if ($clipboardText -eq $null) {
    Write-Host "Die Zwischenablage ist leer."
} else {
    $export = @()
    $clientList = $clipboardText -split "`r`n"
        foreach ($client in $clientList) {
        $ADComputer = Get-ADComputer $client -Properties ManagedBy 
        $ADUser = Get-ADUser $ADComputer.ManagedBy -Properties DisplayName, Department
        Write-Host $client
        $export += $client + ";" + $ADUser.SamAccountName + ";" + $ADUser.DisplayName + ";" + $ADUser.Department 
        
    }
    Set-Clipboard -Value $export
}   

