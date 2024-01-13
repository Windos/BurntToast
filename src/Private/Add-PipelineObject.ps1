# Helper function to inject arbitrary objects into a pipeline stream
function Add-PipelineObject {
    [cmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Object[]] $InputObject,

        [Parameter(Mandatory)]
        [scriptblock] $Process
    )

    Process {
        $_
    }

    End {
        $Process.Invoke()
    }
}
