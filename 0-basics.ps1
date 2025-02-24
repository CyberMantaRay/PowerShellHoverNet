# Overview of basic Powershell syntax

conditionals
printDivider
loops
printDivider
arrays
printDivider
hashtables

<# Methods ------------------------------------------------- #>

function conditionals {
    Write-Host "Starting Conditionals"
    $x=1
    if($x -eq 1) {
        Write-Host "`t`$x is equal to 1"
    } elseif($x -gt 1) {
        Write-Host "`t`$x is greater than 1"
    } else {
        Write-Host "`t`$x is less than 1"
    }
}

function loops {
    Write-Host "Starting Loop..."
    for($i=0; $i -le 8; $i++) {
        Write-Host "`tVal: $i"
    }
}

function arrays {
    Write-Host "Listing pets..."
    $arr = ("Kali", "Oliver", "Monty", "Poppy", "Luther")
    foreach ($item in $arr) {
        echo "`tPet: $item"
    }
}

function hashtables {
    echo "Analyzing Avatars..."
    $htbl = @{
        Kyoshi="Earth";
        Roku="Fire";
        Aang="Air";
        Korra= @{ nation="Water"; villans=("Amon", "Kuvira", "Zaheer", "Unalaq", "Vaatu") }
    }
        
    $htbl
    echo "`nAvatar Korra was born to the $($htbl.Korra.nation) Tribe. She defeated numerous foes:"
    $htbl['Korra']['villans']
}

# Helpers ----------------------------------------------------

function printDivider {
    Write-Host "`n-------------------------------------`n"
}
