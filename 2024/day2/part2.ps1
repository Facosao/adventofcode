function Test-Level {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.Object[]] $Line
    )

    Process {
        $currentSafe = $true

        $previous = 0
        $direction = 0
        
        foreach ($levelStr in $line) {
            $level = [int]$levelStr
            
            if (!$currentSafe) {
                return $previous
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

            if ($currentSafe) {
                $previous = $level
            }
        }

        if (!$currentSafe) {
            return $level
        }

        return $true
    }
}

function Main {
    # $filePath = ".\2024\day2\input\example.txt"
    $filePath = ".\2024\day2\input\input.aoc"
    $content = Get-Content $filePath

    $safe = 0

    foreach ($line in $content) {
        $split = $line -split ' '
        $result = Test-Level -Line $split

        if ($result -is [int]) {
            $index = $split.IndexOf([String]$result)
            if ($index -ge 0) {
                $newSplit = $split[0..($index - 1)] + $split[($index + 1)..($split.Length - 1)]
            }

            $result2 = Test-Level -Line $newSplit
            if ($result2 -is [boolean]) {
                $result = $result2
            } else {
                $result = $false
            }

        }

        if ($result) {
            $safe += 1
        }
    }

    Write-Output $safe
}

Main
