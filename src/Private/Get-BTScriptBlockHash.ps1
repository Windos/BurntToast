function Get-BTScriptBlockHash {
    <#
        .SYNOPSIS
        Returns a normalized SHA256 hash for a ScriptBlock.

        .DESCRIPTION
        Converts the ScriptBlock to string, collapses whitespace, trims, lowercases, and returns SHA256 hash.
        Used to uniquely identify ScriptBlocks for event registration scenarios.

        .PARAMETER ScriptBlock
        The [scriptblock] to hash.

        .INPUTS
        System.Management.Automation.ScriptBlock

        .OUTPUTS
        String (SHA256 hex)

        .EXAMPLE
        $hash = Get-BTScriptBlockHash { Write-Host 'Hello' }
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [scriptblock]$ScriptBlock
    )
    process {
        # Remove all whitespace and semicolons for robust logical identity
        $normalized = ($ScriptBlock.ToString() -replace '[\s;]+', '').ToLowerInvariant()
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($normalized)
        $sha = [System.Security.Cryptography.SHA256]::Create()
        $hashBytes = $sha.ComputeHash($bytes)
        -join ($hashBytes | ForEach-Object { $_.ToString('x2') })
    }
}