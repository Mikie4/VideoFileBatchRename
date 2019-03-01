param([String]$title='UNNAMED',[String]$season='01',[String]$fixSeason="",[String]$fixTitle="")

# Create Test Files #
#ForEach($x in 95..125){$y = $x-100;New-Item -ItemType 'file' -Path .\TestFiles -Name "$x Title $y.txt";}

$folder = ".\"

<#
$foldername = New-Object System.Windows.Forms.FolderBrowserDialog
$foldername.Description = "Select a folder"
if($foldername.ShowDialog() -eq "OK")
{
    $folder += $foldername.SelectedPath
}
#>

if($fixSeason.Length -eq 0)
{
    $fs = $FALSE
}
else
{
    $fs = $TRUE
}
if($fixTitle.Length -eq 0)
{
    $ft = $FALSE
}
else
{
    $ft = $TRUE
}

$files = Get-ChildItem "$folder"

If($fs)
{
    ForEach($file in $files){
        If( $file -match "\w+\.S\d\dE\d+")
        {   
            $oldSeason = $file.Name[$file.Name.IndexOf('.')+2]+$file.Name[$file.Name.IndexOf('.')+3]
            $stitle = $file.Name.Replace(".S$oldSeason",".S$FixSeason")            
            Rename-Item -Path $file.PSPath -NewName $stitle
        }
    }
}
If($ft)
{
    ForEach($file in $files){
        If( $file -match "\w+\.S\d\dE\d+")
        {
            $oldTitle = ""
            ForEach($i in 0..($file.Name.IndexOf('.')-1)){
                $oldTitle = $oldTitle + $file.Name[$i]
            }   
            $ttitle = $file.Name.Replace("$oldTitle","$FixTitle")   
            Rename-Item -Path $file.PSPath -NewName $ttitle
        }
    }
}

If(-not $fs -and -not $ft)
{
    $files = Get-ChildItem "$folder"
    $title = "$title.S$season" + "E"
    ForEach($file in $files){
        If( $file -match "\d+ \w+")
        {
            $bfileName = ""
            $bfileName = $filename.Name
            $regFile = $file.Name | Select-String -Pattern '(^\d+)'
            $episode = $regFile.Matches.Value
            Rename-Item -Path $file.PSPath -NewName "$title$episode"
        }
    }
}
