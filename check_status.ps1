$script_path="c:\Octopus\Files\check.ps1"
Start-Job -FilePath $script_path
sleep 30
Get-Job
$HTTP_Request = [System.Net.WebRequest]::Create('http://localhost:5000/')
$HTTP_Response = $HTTP_Request.GetResponse()
$HTTP_Status = [int]$HTTP_Response.StatusCode
If ($HTTP_Status -eq 200) {
    Write-Host "Site is OK!"
}
Else {
    Write-Host "The Site may be down, please check!"
}
$HTTP_Response.Close()
