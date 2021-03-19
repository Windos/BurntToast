function Add-BTText {
    <#
        .SYNOPSIS
        Add text to the toast.

        .DESCRIPTION
        The Add-BTText function adds custom text to a toast notification via a content builder object.

        .INPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder. You can pipe a toast content builder object to Add-BTText.

        System.String. You can provide multiple strings at once, but they cannot be piped.

        .OUTPUTS
        None. The Add-BTText function does not provide any output by default.

        You can optionally use the PassThru parameter to output the updated toast content builder object, which enables chaining functions together.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTText -ContentBuilder $Builder -Text 'First Line of Text'

        This example adds one custom text element to the toast content builder object stored in the $Builder variable using the ContentBuilder parameter explicitly.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text'

        This example adds one custom text element to the toast content builder object stored in the $Builder variable by piping it into the Add-BTText function.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text', 'Second Line of Text'

        This example adds two custom text elements to a toast content builder object with a single call of the Add-BTText function.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text'

        PS C:\>$Builder | Add-BTText -Text 'Second Line of Text'

        This example adds two custom text elements to a toast content builder object with two discrete calls of the Add-BTText function.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text' -PassThru |
                          Add-BTText -Text 'Second Line of Text' -PassThru |
                          Add-BTText -Text 'Third Line of Text'

        This example adds three custom text elements to a toast content builder object using multiple calls of the Add-BTText function on the pipeline.

        The PassThru parameter is used to pass the toast content builder down the pipeline. Note that this is not required at the end of the pipeline as the builder object being added to is already stored in a variable.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text'

        PS C:\>$Builder | Add-BTText -Text 'Second Line of Text'

        PS C:\>$Builder | Add-BTText -Text 'Third Line of Text'

        PS C:\>$Builder | Add-BTText -Text 'Fourth Line of Text'

        This example attempts to add four custom text elements to a toast content builder object.

        Only the first three of these elements will be added and the fourth will generate a warning stating that the maximum number of lines has been reached.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text' -MaxLines 1

        PS C:\>$Builder | Add-BTText -Text 'Second Line of Text',
                                           'Third Line of Text',
                                           'Fourth Line of Text'

        This example sets the max lines for the first custom text element to 1, overriding the default value of 2.

        This means the toast notification can now accept four custom text elements, each with a max line count of 1, for a total line count of 4.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'First Line of Text' -Language en-NZ

        Thie example specifies that the language included in the text element is New Zealand English using the relevant BCP-47 code, en-NZ.

        .NOTES
        A toast notification can contain a maximum of four reserved lines of text. By default this means you can include three customer text elements as the first, which acts like a heading, automatically reserves 2 lines.

        You can override this behaviour using the MaxLines parameter, specifically by setting the first line to a maximum of 1 line.

        This function will ignore any text elements that would exceed this limit and output a warning stating this.

        .LINK
        https://docs.toastit.dev/commands/add-bttext
    #>

    [CmdletBinding()]
    param (
        # The toast content builder obejct that represents the toast notification being constructed.
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder] $ContentBuilder,

        # Custom text to display on the tile.
        [Parameter(Mandatory,
                   Position = 0)]
        [ValidateNotNull()]
        [ValidateCount(1,4)]
        [string[]] $Text,

        # The maximum number of lines the text element is allowed to display.
        [ValidateRange(1,2)]
        [int] $MaxLines,

        # The target locale of the toast notification, specified as a BCP-47 language tags such as "en-US" or "fr-FR".
        # The locale specified here overrides any other specified locale, such as that in binding or visual.
        [string] $Language,

        # Returns an object that represents the item with which you're working. By default, this cmdlet doesn't generate any output.
        [switch] $PassThru
    )

    begin {}
    process {
        $paraStyle    = $null
        $paraWrap     = $null
        $paraMaxLines = if ($MaxLines) {$MaxLines} else {$null}
        $paraMinLines = $null
        $paraAlign    = $null

        try {
            foreach ($Line in $Text) {
                if ($Language) {
                    $null = $ContentBuilder.AddText($Line,
                                                    $paraStyle,
                                                    $paraWrap,
                                                    $paraMaxLines,
                                                    $paraMinLines,
                                                    $paraAlign,
                                                    $Language)
                } else {
                    $null = $ContentBuilder.AddText($Line,
                                                    $paraStyle,
                                                    $paraWrap,
                                                    $paraMaxLines,
                                                    $paraMinLines,
                                                    $paraAlign)
                }
            }
        } catch {
            Write-Warning ('The max lines of text (4) on the toast notification has been reached, extra lines have been ignored. ' +
                'The first text element automatically reserves 2 lines of text, consider using the MaxLines parameter to override this.')
        }

        if ($PassThru) {
            $ContentBuilder
        }
    }
    end {}
}