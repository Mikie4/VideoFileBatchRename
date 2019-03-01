Parameters:

[String]$title='UNNAMED' - Used to set title. Only applies to 'Pre-corrected filenames'
[String]$season='01' - Used to set season. Only applies to 'Pre-corrected filenames'
[String]$FixSeason="" - Used to corrected mistyped season. Only applies to 'Post-corrected filenames'
[String]$FixTitle="" - Used to corrected mistyped title. Only applies to 'Post-corrected filenames'

-NOTE: -FixSeason and FixTitle will not both pass together. Season will process properly but change the filename before title is able to process, breaking the Rename-Item $filename command (this filename no longer exists because its been renamed by -FixSeason). This will not break any of the files, but will throw errors and not change the title. -FixTitle will then need to be reran by itself.

----------------------------------
Pattern for 'Pre-corrected filenames'
\d+ \w+
(Any number of digits followed by a space followed by any number of words)

Pattern for 'Post-Corrected filenames'
\w+\.S\d\dE\d+
(Any number of words followed by a period followed by 'S' followed by 2 digits followed by 'E' followed by any number of digits)

Patterns can be changed for Pre-corrected filenames on line 67 in the IF statement, 
    ForEach($file in $files){
        If( $file -match "\d+ \w+")
        {

----------------------------------
Usage Examples

.\VideoFileBatchRename.ps1 -title "He Man Masters of the Universe"
Result: '102 Teela's Quuest' => 'He Man Masters of the Universe.S01E102'

.\VideoFileBatchRename.ps1 -title "He Man Masters of the Universe" -season "03"
Result: '102 Teela's Quuest' => 'He Man Masters of the Universe.S03E102'

.\VideoFileBatchRename.ps1 
Result: '102 Teela's Quuest' => 'UNNAMED.S01E102'

.\VideoFileBatchRename.ps1 -season "02"
Result: '102 Teela's Quuest' => 'UNNAMED.S02E102'

.\VideoFileBatchRename.ps1 -fixTitle "My Little Pony"
Result: 'He Man Masters of the Universe.S01E102' => 'My Little Pony.S01E102'

.\VideoFileBatchRename.ps1 -fixSeason "04"
Result: 'He Man Masters of the Universe.S01E102' => 'He Man Masters of the Universe.S04E102'


