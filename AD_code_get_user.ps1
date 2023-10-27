<#


    Author : LALA Anthony
    


#>


#Site
#FILL YOUR DOMAIN
$arraySite = @{
    'ChoiceVisible' = @{'nameDomain' = @('x','xx')};
    }

#FILL YOUR DOMAIN
$domainSpecific = "OU=x,DC=x,DC=x"


#Init.
$objUsers = @{}
$nameConfigFile = "configFileUser.txt"

#Get path Launcher
if($PSscriptroot){

	$directoryLauncher = $PSscriptroot

}else{
	$fullPathLauncher = [system.Diagnostics.Process]::GetCurrentProcess().mainModule.FileName
	$directoryLauncher = [System.IO.Path]::GetDirectoryName($fullPathLauncher)
}

#Build path config file
$nameFileConfiguration = $directoryLauncher + "\" + $nameConfigFile


<#


    Class User
    


#>

Class User {

    #Attribut
    [string]$name
    [string]$surname
    [string]$ID
    [string]$email
    [string]$status
    [string]$group
    [string]$site


    #Constructor
    User($user){

       $this.name = $user.GivenName
       $this.surname = $user.surname
       $this.ID = $user.samAccountName
       $this.email = $user.UserPrincipalName

       #Status account
       if($user.Enabled){
        $this.status = "Enable"
       }else{
        $this.status = "Disable"
       }

       #Define group    
       if($user.MemberOf | where {$_ -match '([0-9]{2}[0-9A-Z_]{1,})'} | % {$matches} ){
        $this.group = $matches[0]
       }else{
        $this.group = "Inconnu"
       }

       #FILL YOUR DOMAIN
       if($user.MemberOf | where {$_ -match 'x'} | % {$matches} ){
        $this.site = $matches[0]
       }elseif($user.MemberOf | where {$_ -match 'xx'} | % {$matches} ){
        $this.site = $matches[0]
       }else{
        $this.site = "Unknow"
       }
    }
 
 }


<#


    Functions
    


#>

#Load file config
function loadAD($site){


        
    #Get Users AD
    foreach($tmp in $arraySite.$site.nameDomain){
		$listUsers += Get-ADUser -SearchBase "OU=$tmp,$domainSpecific" -Filter {ObjectClass -eq 'user'} -Properties Name,MemberOf,SamAccountName,userPrincipalName,CanonicalName
	} 
        
    foreach($user in $listUsers){
    
        #NeW computer
		$objUser = [User]::new($user)
        $objUsers.Add($objUser.ID,$objUser)
    
    }  

    #Export to JSON
    exportJSON
}


#Export Json configFileComputer
function exportJSON(){

	#Init.
	$arrayConfig = @{}

	$date = Get-Date -Format "dd/MM/yyyy"
	$param = @{"Last_update" = $date }
	$arrayConfig.Add("Parameters",$param)

	#Add Computer array to config array
	$arrayConfig.Add( "Users" , $objUsers)

	#Export Configuration
	$arrayConfig | ConvertTo-Json | Out-File $nameFileConfiguration
	

}

<#


    Launch app
    


#>

#FILL YOUR DOMAIN
loadAD("SFC")