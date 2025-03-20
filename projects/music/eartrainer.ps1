<#
 # @author Andor Light
 # @github CyberMantaRay
#>

[string[]]$NATURAL_NOTES = @("A3", "B3", "C4", "D4", "E4", 
    "F4", "G4", "A4", "B4", "C5")

$FREQ_MAP = @{
    A3 = 220
    B3 = 246.94
    C4 = 261.63
    D4 = 293.66
    E4 = 329.63
    F4 = 349.23
    G4 = 392
    A4 = 440
    B4 = 493.88
    C5 = 523.25
}


#--------------------
#--- HELPERS --------
#--------------------

function Play-Note ($note) {
    [console]::Beep($FREQ_MAP[$note], 1600)
    # [console]::Beep([Math]::Round($freq), 1600)
}

function Get-RandomNote {
    $randNoteIdx = Get-Random $NATURAL_NOTES.Length
    # $note = $NATURAL_NOTES[$noteIdx]
    return @{
        noteIdx = $randNoteIdx
        note   = $NATURAL_NOTES[$randNoteIdx]
    }
}

#--------------------------
#--- TRAINING MENU --------
#--------------------------

function Name-Note {
    $numCorrect=0;

    :MODE_NAMING while ($true) {
        $randomNote = Get-RandomNote
        $answer = $randomNote.note.substring(0,1)

        Write-Host "Identify the note`t`t[P]lay $($randomNote.note)  $($answer)"
                
        while($true){
            $keyInfo = [System.Console]::ReadKey($true)

            if ($keyInfo.Key -eq $randomNote.note.substring(0,1)) {
                $numCorrect++; break
            }

            switch ($keyInfo.Key) {
                P { Play-Note $randomNote.note }
                X { break PROGRAM }
                Q { break PROGRAM }
                default {}
            }
        }
    }
}


function Sing-Note {}


###########################
####   BEGIN SCRIPT   #####
###########################

Write-Host "`n`tMusical Ear Trainer 𝄞 (E[x]it)`n"

:PROGRAM while ($true) {
    $selection = Get-RandomNote
    Write-Host "Select a training routine: (1) Name ♪ (2) Sing ♪"

    :MODE while ($true) {
        $keyInfo = [System.Console]::ReadKey($true)
        # Write-Host $keyInfo.Key " --------"

        switch ($keyInfo.Key) {
            D1 { Name-Note }
            X { break PROGRAM }
            Q { break PROGRAM }
            default {}
        }
    }
}

Write-Host "`nSolid session, see you next time! 🔥`n_________________________________`n`n"


<# SAMPLE RUN

        Musical Ear Trainer 𝄞 (E[x]it)

Select a training routine: (1) Name ♪ (2) Sing ♪
Identify the note               [P]lay C5  C
Identify the note               [P]lay A3  A
Identify the note               [P]lay F4  F

Solid session, see you next time! 🔥
_________________________________


#>
