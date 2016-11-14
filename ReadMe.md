## About
This PowerShell script will download the awesome `sp_WhoIsActive` procedure from http://www.whoisactive.com/  and
deploy it to your server.

## Example
```powershell
Add-SpWhoIsActive -ServerInstance localhost -Verbose
```
Gives (as at 14 Nov 2016)
```
VERBOSE: GET http://www.whoisactive.com/ with 0-byte payload
VERBOSE: received 1463-byte response of content type text/html
VERBOSE: GET http://www.whoisactive.com/who_is_active_v11_17.zip with 0-byte payload
VERBOSE: received 26370-byte response of content type application/zip
VERBOSE: Deploying sp_whoisactive
VERBOSE: Changed database context to 'master'.
```