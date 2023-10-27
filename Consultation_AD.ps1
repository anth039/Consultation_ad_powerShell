<#


    Author : LALA Anthony
   


#>

#Init.
$objUsers = @{}
$nameConfigFile = "configFileUser.txt"
$Global:arrayConfig

#Get path Launcher
if($PSscriptroot){
	$directoryLauncher = $PSscriptroot
}else{
	$fullPathLauncher = [system.Diagnostics.Process]::GetCurrentProcess().mainModule.FileName
	$directoryLauncher = [System.IO.Path]::GetDirectoryName($fullPathLauncher)
}

#Build path config file
$nameFileConfiguration = $directoryLauncher + "\" + $nameConfigFile

#Loading assemblies
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

<#


            GRAPHIC PARTY (Form)
    
    
#>

#Graphics
$Form                                  = New-Object system.Windows.Forms.Form
$Form.ClientSize                       = '1100,400'
$Form.text                             = "AD consult"
$Form.TopMost                          = $false
$Form.FormBorderStyle                  = 'Fixed3D'
$Form.MaximizeBox                      = $false
$Form.StartPosition                    = "CenterScreen"

#Data
$dataGridView_view                     = New-Object system.Windows.Forms.DataGridView
$dataGridView_view.width               = 1078
$dataGridView_view.height              = 299
$dataGridView_view.location            = New-Object System.Drawing.Point(13,50)
$dataGridView_view.ColumnCount         = 7
$dataGridView_view.ColumnHeadersVisible = $true
$dataGridView_view.AllowUserToAddRows  = $false
$dataGridView_view.AllowUserToDeleteRows = $false
$dataGridView_view.AllowUserToResizeColumns = $false
$dataGridView_view.AllowUserToResizeRows = $false
$dataGridView_view.rowHeadersVisible   = $false
$dataGridView_view.AutoSizeColumnsMode = 16
$dataGridView_view.ReadOnly = $true
$dataGridView_view.columns[0].Width    = 100#Name
$dataGridView_view.columns[1].Width    = 100#Surname
$dataGridView_view.columns[2].Width    = 150#ID
$dataGridView_view.columns[3].Width    = 300#Email
$dataGridView_view.columns[4].Width    = 50#Status account
$dataGridView_view.columns[6].Width    = 100#Site
#Configuring columns dataGridView_view
$dataGridView_view.Columns[0].Name     = "Name"
$dataGridView_view.Columns[1].Name     = "Surname"
$dataGridView_view.Columns[2].Name     = "ID"
$dataGridView_view.Columns[3].Name     = "Email"
$dataGridView_view.Columns[4].Name     = "Status"
$dataGridView_view.Columns[5].Name     = "Group"
$dataGridView_view.Columns[6].Name     = "Site"
#Configuring style
$dataGridView_view.ColumnHeadersDefaultCellStyle.Alignment = 'middlecenter'
$dataGridView_view.Columns[2].DefaultCellStyle.Alignment = 'middlecenter'
$dataGridView_view.Columns[3].DefaultCellStyle.Alignment = 'middlecenter'
$dataGridView_view.Columns[4].DefaultCellStyle.Alignment = 'middlecenter'
$dataGridView_view.Columns[5].DefaultCellStyle.Alignment = 'middlecenter'
$dataGridView_view.Columns[6].DefaultCellStyle.Alignment = 'middlecenter'

$label_filter                          = New-Object System.Windows.Forms.label
$label_filter.text                     = "Filter"
$label_filter.Location                 = New-Object System.Drawing.Point(970,13)
$label_filter.Size                     = New-Object System.Drawing.Size(40,12)
$label_filter.font                     = [System.Drawing.Font]::new("Microsoft Sans Serif", 8, [System.Drawing.FontStyle]::Bold)

$label_numberRow                       = New-Object System.Windows.Forms.label
$label_numberRow.text                  = "Row : "
$label_numberRow.Location              = New-Object System.Drawing.Point(550,355)
$label_numberRow.Size                  = New-Object System.Drawing.Size(80,30)

$label_lastUpdate                      = New-Object System.Windows.Forms.label
$label_lastUpdate.text                 = "Last Update : "
$label_lastUpdate.Location             = New-Object System.Drawing.Point(10,7)
$label_lastUpdate.Size                 = New-Object System.Drawing.Size(300,20)

$textBox_filter                        = New-Object System.Windows.Forms.TextBox
$textBox_filter.Location               = New-Object System.Drawing.Point(890,28)
$textBox_filter.Size                   = New-Object System.Drawing.Size(200,30)
$textBox_filter.MaxLength              = 30

$status_barSystem			           = New-Object System.Windows.Forms.StatusBar
$status_barSystem.width                = 120
$status_barSystem.height               = 20
$status_barSystem.location             = New-Object System.Drawing.Point(850,20)

#Add controls Form
$Form.controls.AddRange(@($label_lastUpdate,$status_barSystem,$label_filter,$textBox_filter,$dataGridView_view,$label_numberRow))


<#


            FUNCTION PARTY
            
            
#>

#Load file config
function loadAD(){
    
    #check if $datagridview already full
    if($dataGridView_view.Rows.Count -eq 0){

        #Get configuration
        $Global:arrayConfig = Get-Content -Raw -Path $nameFileConfiguration| ConvertFrom-Json
   
		#Parameters
		$label_lastUpdate.text = "Last update : " + $arrayconfig.Parameters.Last_update
   
        foreach ($property in $arrayconfig.Users.PSObject.Properties){
   
            #Add datagridview
            $tmp = $property.name
		    $user = $Global:arrayConfig.Users.$tmp
            
            $dataGridView_view.Rows.Add($user.name,$user.surname,$user.ID,$user.email,$user.status,$user.group,$user.site)
            
        }

        #Sort
        $dataGridView_view.Sort($dataGridView_view.Columns[0], 'Ascending')

        #Update Number Row
        $label_numberRow.text = "Row : " + $dataGridView_view.Rows.GetRowCount([System.Windows.Forms.DataGridViewElementStates]::Visible)
        
    }
}

<#


            FUNCTION EVENTS PARTY
            
            
#>

#Click view dataGridView_view
function data_view_click(){
    
	#Add data in clipboart
    if($this.Rows[$this.selectedCells[0].rowindex].Cells[$this.selectedCells[0].columnindex].value){
	    $divers = $this.Rows[$this.selectedCells[0].rowindex].Cells[$this.selectedCells[0].columnindex].value
	    Set-Clipboard -Value $divers
	    $status_barSystem.text = $divers + " Copied !"
    }else{
        $status_barSystem.text = "Value empty !"
    }

}

#Filter on dataGridView_view
function filter_view(){
    #Initi.
    $type = ""
    $test = $false
    $test2= $false

    #Get field fill
    $search_value = $textBox_filter.text
    
    #Datagridview visible enable
    if($dataGridView_view.Visible){
        $dataGrid = $dataGridView_view
    }else{
        $dataGrid = $dataGridView_view_Out
    }

    #Multi search
    if($search_value){
       
        if($search_value -like "*+*"){
            $tabSearch = $search_value.Split("+")
            $type = "+"
        }elseif($search_value -like "*&*"){
            $tabSearch = $search_value.Split("&")
            $type = "&"
        }else{
            $tabSearch = $search_value.replace("+","").replace("&","")
        }

        #Improve
        $tabSearch = $tabSearch.Where({ $_ -ne "" })
         
    }

    #Filter rows
    for($i=0;$i -lt $dataGrid.RowCount;$i++){
        $rowFull = ""
        for($j=0;$j -lt $dataGrid.ColumnCount;$j++){

            $rowFull = $rowFull + " " + $dataGrid.Rows[$i].Cells[$j].Value

        }
        $l=0
        for($k=0;$k -lt $tabSearch.Count;$k++){
            if($rowFull -like "*"+ $tabSearch[$k] +"*"){
                    $l++
            }
        }

        if(($l -and !$type) -or ($l -gt 0 -and $type -eq "+") -or ($type -eq "&" -and $l -eq $tabSearch.Count)-or !$tabSearch){
            $test = $true
         }

        if($test){
            $dataGrid.Rows[$i].visible = $true
        }else{
            $dataGrid.Rows[$i].visible = $false
        }
        $test=$false

    }

    #Update Number Row
    $label_numberRow.text = "Row : " + $dataGrid.Rows.GetRowCount([System.Windows.Forms.DataGridViewElementStates]::Visible)

}


#Load Form 
function loadForm (){
	
	#Load file config
    loadAD
		
}



<#


            EVENTS PARTY
            
            
#>

$Form.Add_Shown({ loadForm })
$textBox_filter.Add_TextChanged({filter_view})
$dataGridView_view.Add_CellDoubleClick({data_view_click})

<#

            LAUNCH PARTY
            
            
#>

#Open Form
$Form.ShowDialog()




