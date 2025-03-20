<#
 # @author Andor Light
 # @github CyberMantaRay
#>

[string[]]$NATURAL_NOTES = @("E2", "F2", "G2", "A2", "B2",
    "C3", "D3", "E3", "F3", "G3", "A3", "B3",
    "C4", "D4", "E4", "F4", "G4", "A4", "B4",
    "C5", "D5", "E5")

[string[]]$GUITAR_STRINGS = "E2", "A2", "D3", "G3", "B3", "E4"
[string[]]$GUITAR_STRINGS_DISPLAY = "Low E", "A", "D", "G", "B", "High E"

$GTR_STR_TO_NOTE_IDX_MAP = @{
    "E2" = 0
    "A2" = 3
    "D3" = 6
    "G3" = 9
    "B3" = 11
    "E4" = 14
}

$FREQ_MAP = @{
    E2 = 82.41
    F2 = 87.31
    G2 = 98
    A2 = 110
    B2 = 123.47
    C3 = 130.81
    D3 = 146.83
    E3 = 164.81
    F3 = 174.61
    G3 = 196
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
    D5 = 587.33
    E5 = 659.26
}

function Play-Note ($note) {
    [console]::Beep($FREQ_MAP[$note], 1600)
    # [console]::Beep([Math]::Round($freq), 1600)
}

function Get-RandomNote {
    # $guitarString = Get-Random -InputObject $GUITAR_STRINGS
    $guitarStringIdx = Get-Random 6
    $startIdx = $GTR_STR_TO_NOTE_IDX_MAP[$GUITAR_STRINGS[$guitarStringIdx]]
    $randNoteOffset = Get-Random -Minimum 1 -Maximum 8  # Limit notes till 12th fret
    $noteIdx = $startIdx + $randNoteOffset
    $note = $NATURAL_NOTES[$noteIdx]
    return @{
        Note   = $note
        GuitarStringIdx = $guitarStringIdx
    }
}


###########################
####   BEGIN SCRIPT   #####
###########################

Write-Host "`n`tGuitar Fretboard Trainer 🎸 (E[x]it)`n"

$exerciseCount=0

:PROGRAM while ($true) {
    $selection = Get-RandomNote
    Write-Host "Play ♪ $($selection.Note.Substring(0,1)) on the $($GUITAR_STRINGS_DISPLAY[$selection.GuitarStringIdx]) string $(if ($exerciseCount%12 -eq 0) { "`t`t([p]lay, Enter/Space -> Next Note)" })"

    :MENU while ($true) {
        $keyInfo = [System.Console]::ReadKey($true)
        if ($keyInfo.Key -eq "P") {
            Play-Note $selection.Note
        } elseif ($keyInfo.Key -eq "Enter" -OR $keyInfo.Key -eq "Spacebar" ) {
            break
        } elseif ($keyInfo.Key -eq "X" -OR $keyInfo.Key -eq "Q") {
            break PROGRAM
        }
    }

    $exerciseCount++
}

Write-Host "`nSolid session, see you next time! 🔥`n_________________________________`n`n"


<# SAMPLE OUTPUT

        Guitar Fretboard Trainer 🎸 (E[x]it)

Play ♪ G on the A string        ([p]lay, Enter/Space -> Next Note)
Play ♪ A on the High E string   ([p]lay, Enter/Space -> Next Note)
Play ♪ D on the G string        ([p]lay, Enter/Space -> Next Note)
Play ♪ F on the Low E string    ([p]lay, Enter/Space -> Next Note)
Play ♪ B on the A string        ([p]lay, Enter/Space -> Next Note)
Play ♪ A on the G string        ([p]lay, Enter/Space -> Next Note)
Play ♪ B on the B string        ([p]lay, Enter/Space -> Next Note)
Play ♪ F on the Low E string    ([p]lay, Enter/Space -> Next Note)

Solid session, see you next time! 🔥
_________________________________


#>
