function Main {
    # $filePath = ".\2024\day1\input\example.txt"
    $filePath = ".\2024\day1\input\input.aoc"
    $content = Get-Content $filePath

    [System.Collections.ArrayList]$leftColumn = @()
    $rightColumn = @{}

    foreach ($line in $content) {
        $split = $line -split '   '
        $leftColumn += [int]$split[0]
        $2ndValue = [int]$split[1]

        if ($2ndValue -in $rightColumn.Keys) {
            $rightColumn[$2ndValue] += 1
        } else {
            $rightColumn.Add($2ndValue, 1)
        }
    }

    $similarity = 0

    for ($i = 0; $i -lt $leftColumn.Count; $i++) {
        if ($leftColumn[$i] -in $rightColumn.Keys) {
            $similarity += $leftColumn[$i] * $rightColumn[$leftColumn[$i]]
        }
    }

    Write-Output $similarity
}

Main
