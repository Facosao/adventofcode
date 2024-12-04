function Main {
    # $filePath = ".\2024\day2\input\example.txt"
    $filePath = ".\2024\day2\input\input.aoc"
    $content = Get-Content $filePath
    # [System.Collections.ArrayList]$reports = @()

    $safe = 0

    foreach ($line in $content) {
        # [System.Collections.ArrayList]$numbers = @()
        $split = $line -split ' '
        
        $currentSafe = $true

        $previous = 0
        $direction = 0
        
        foreach ($levelStr in $split) {
            $level = [int]$levelStr
            
            if (!$currentSafe) {
                break
            }

            if ($previous -eq 0) {
                $previous = $level
                continue
            } else {
                if ($direction -eq 0) {
                    if ($previous -eq $level) {
                        $currentSafe = $false
                        break
                    }
                    if ($previous -lt $level) {
                        $direction = 1
                    } 
                    if ($previous -gt $level) {
                        $direction = -1
                    }
                }
           
                if ($direction -eq 1) {
                    $currentSafe = $currentSafe -and ($previous -lt $level)
                }
                if ($direction -eq -1) {
                    $currentSafe = $currentSafe -and ($previous -gt $level)   
                }
                
                $sub = [Math]::Abs($previous - $level)
                $currentSafe = $currentSafe -and 
                    (($sub -ge 1) -and ($sub -le 3) -and ($sub -ne 0))
            }

            $previous = $level
        }

        if ($currentSafe) {
            $safe += 1
        }
    }

    Write-Output $safe
}

Main
