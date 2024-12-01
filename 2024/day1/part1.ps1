function Main {
    $filePath = ".\2024\day1\input\example.txt"
    # $filePath = ".\2024\day1\input\input.aoc"
    $content = Get-Content $filePath

    [System.Collections.ArrayList]$leftColumn = @()
    [System.Collections.ArrayList]$rightColumn = @()

    foreach ($line in $content) {
        $split = $line -split '   '
        $leftColumn += [int]$split[0]
        $rightColumn += [int]$split[1]
    }

    $leftColumn = $leftColumn | Sort-Object
    $rightColumn = $rightColumn | Sort-Object

    $acc = 0

    for ($i = 0; $i -lt $leftColumn.Count; $i++) {
        $distance = [Math]::Abs($leftColumn[$i] - $rightColumn[$i])
        $acc += $distance
    }

    Write-Output $acc
}

Main
