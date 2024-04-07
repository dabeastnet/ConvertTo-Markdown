<#
.SYNOPSIS
Converts input objects (arrays, hashtables, and PSCustomObjects) to Markdown format.

.DESCRIPTION
Author: Dieter Beckers 2024
Version: 1.0 APR 24
The ConvertTo-Markdown function takes input objects of types array, hashtable, or PSCustomObject and converts them into Markdown format. 
- For arrays, it generates a Markdown list where each item of the array is a list item.
- For hashtables and PSCustomObjects, it generates a Markdown table. Each property of the hashtable or PSCustomObject becomes a column in the table.

.PARAMETER InputObject
The input object to be converted to Markdown format. This can be an array, hashtable, or PSCustomObject. The function processes these objects from the pipeline.

.EXAMPLE
$array = 1..5
$array | ConvertTo-Markdown

Outputs a Markdown list of numbers from 1 to 5.

.EXAMPLE
$hashtable = @{Name='John Doe'; Age=30; Department='IT'}
$hashtable | ConvertTo-Markdown

Converts the hashtable to a Markdown table with columns for Name, Age, and Department.

.EXAMPLE
$object = [PSCustomObject]@{Name='Jane Doe'; Age=29; Department='HR'}
$object | ConvertTo-Markdown

Converts the PSCustomObject to a Markdown table with columns for Name, Age, and Department.

.NOTES
This function is designed to work with simple arrays, hashtables, and PSCustomObjects. It does not support nested objects or arrays within these structures for Markdown table conversion.

.LINK
https://www.markdownguide.org/basic-syntax/

#>

function ConvertTo-Markdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object]$InputObject
    )

    begin {
        $collectedInput = @()
    }

    process {
        $collectedInput += $InputObject
    }

    end {
        # Now, $collectedInput is the entire collection of inputs
        Write-Debug "$($collectedInput.GetType()) with $($collectedInput.Count) items"
        if ($collectedInput[0] -is [int]) {
            Write-Debug "Handling as array"
            foreach ($item in $collectedInput) {
                Write-Output "- $item"
            }
        }
        elseif ($collectedInput[0] -is [System.Collections.Hashtable] -or $collectedInput[0] -is [PSCustomObject]) {
            Write-Debug "Handling as Hashtable or PScustomOBJ"
            $properties = if ($collectedInput[0] -is [System.Collections.Hashtable]) {
                $collectedInput[0].Keys
            } else {
                $collectedInput[0] | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
            }

            $header = $properties -join " | "
            $separator = ($properties | ForEach-Object { '---' }) -join " | "
            
            $rows = foreach ($obj in $collectedInput) {
                $row = ($properties | ForEach-Object {
                    if ($obj -is [System.Collections.Hashtable]) {
                        $obj[$_]
                    } else {
                        $obj.$_
                    }
                }) -join " | "
                "| $row |"
            }

            $markdownTable = @("| $header |", "| $separator |") + $rows

            $markdownTable -join "`n"
        }
        else {
            Write-Warning "Unsupported input type: $($collectedInput[0].GetType().FullName)"
        }
    }
}
