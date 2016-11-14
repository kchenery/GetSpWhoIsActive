Import-Module SqlPs -DisableNameChecking

Function Get-WhoIsActive {
    [CmdletBinding()]
    Param(
        [string]$Uri
    )

    [System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression') | Out-Null

    $DownloadUri = $Uri + (Invoke-WebRequest -Uri $Uri).Links[0].href
    $ZipBytes = Invoke-WebRequest -Uri $Download
    $ZipStream = New-Object System.IO.Memorystream
    $ZipStream.Write($ZipBytes.Content,0,$ZipBytes.Content.Length)
    $ZipArchive = New-Object System.IO.Compression.ZipArchive($ZipStream)

    $ZippedFile = $ZipArchive.GetEntry($ZipArchive.Entries[0])
    $EntryReader = New-Object System.IO.StreamReader($ZippedFile.Open())
    $Document = $EntryReader.ReadToEnd()
    return $Document
}

Function Add-SpWhoIsActive {
    [CmdletBinding()]
    Param(
        [string]$ServerInstance
    )

    $spWhoIsActive = Get-WhoIsActive -Uri "http://www.whoisactive.com/"

    Write-Verbose "Deploying sp_whoisactive"
    Invoke-Sqlcmd -ServerInstance localhost -Database master -Query $spWhoIsActive
}

Add-SpWhoIsActive -ServerInstance localhost -Verbose