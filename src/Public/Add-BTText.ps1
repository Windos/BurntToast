function Add-BTText {
    <#
        .SYNOPSIS
        Add text to the toast.

        .DESCRIPTION
        The Add-BTText function adds custom text to a toast notification via a content builder object.

        By default this text will be added to the body of the toast. You can also add attribution text using the Attribution switch.

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

        This example specifies that the language included in the text element is New Zealand English using the relevant BCP-47 code, en-NZ.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'Example Toast Source' -Attribution

        This example add attribution test to a toast notification.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTText -Text 'Placeholder String' -Bindable

        This example adds a bindable string to a toast notification that should map to a key/value pair in the toast's data binding property.

        .NOTES
        A toast notification can contain a maximum of four reserved lines of text. By default this means you can include three customer text elements as the first, which acts like a heading, automatically reserves 2 lines.

        You can override this behavior using the MaxLines parameter, specifically by setting the first line to a maximum of 1 line.

        This function will ignore any text elements that would exceed this limit and output a warning stating this.

        Attribution text is displayed underneath other text elements, but above image elements. You can only have one attribution text element per toast notification and adding attribution to a notification will override any existing attribution text.

        .LINK
        https://docs.toastit.dev/commands/add-bttext
    #>

    [CmdletBinding(DefaultParameterSetName = 'CustomText')]
    param (
        # The toast content builder object that represents the toast notification being constructed.
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
        [Parameter(ParameterSetName = 'CustomText')]
        [ValidateRange(1,2)]
        [int] $MaxLines,

        # Specifies that the text should be considered the name of a bindable string to be used when updating information on a toast notification.
        [Parameter(ParameterSetName = 'CustomText')]
        [switch] $Bindable,

        # Specifies that the text should be added as attribution text.
        [Parameter(Mandatory,
                   ParameterSetName = 'AttributionText')]
        [switch] $Attribution,

        # The target locale of the toast notification, specified as a BCP-47 language tags such as "en-US" or "fr-FR".
        # The locale specified here overrides any other specified locale, such as that in binding or visual.
        [string] $Language,

        # Returns an object that represents the item with which you're working. By default, this cmdlet doesn't generate any output.
        [switch] $PassThru
    )

    begin {}
    process {
        if ($Attribution) {
            if ($Text.Count -gt 1) {
                Write-Warning ('Attribution text can only contain a single string and more than one was provided. ' +
                    'Only the first string will be used.')
            }

            if ($null -ne $ContentBuilder.Content.Visual.BindingGeneric.Attribution.Text) {
                Write-Warning ('Attribution text can only be set once per toast notification. ' +
                    'The existing attribution text will be overwritten.')
            }

            if ($Language) {
                $null = $ContentBuilder.AddAttributionText($Text[0], $Language)
            } else {
                $null = $ContentBuilder.AddAttributionText($Text[0])
            }
        } else {
            $paraStyle    = $null
            $paraWrap     = $null
            $paraMaxLines = if ($MaxLines) {$MaxLines} else {$null}
            $paraMinLines = $null
            $paraAlign    = $null

            try {
                foreach ($Line in $Text) {
                    if ($Bindable) {
                        $ExistingLineCount = 0
                        foreach ($ExistingLine in $ContentBuilder.Content.Visual.BindingGeneric.Children) {
                            if ($ExistingLine.GetType().Name -eq 'AdaptiveText') {
                                if ($ExistingLineCount -eq 0 -and $null -eq $ExistingLine.HintMaxLines) {
                                    $ExistingLineCount += 2
                                } else {
                                    $ExistingLineCount += 1
                                }
                            }
                        }

                        if ($ExistingLineCount -ge 4) {
                            throw
                        }

                        $AdaptiveText = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveText]::new()

                        if ($MaxLines) {
                            $AdaptiveText.HintMaxLines = $MaxLines
                        }

                        if ($Language) {
                            $AdaptiveText.Language = $Language
                        }

                        $AdaptiveText.Text = [Microsoft.Toolkit.Uwp.Notifications.BindableString]::new($Line)

                        $null = $ContentBuilder.AddVisualChild($AdaptiveText)
                    } else {
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
                }
            } catch {
                Write-Warning ('The max lines of text (4) on the toast notification has been reached, extra lines have been ignored. ' +
                    'The first text element automatically reserves 2 lines of text, consider using the MaxLines parameter to override this.')
            }
        }

        if ($PassThru) {
            $ContentBuilder
        }
    }
    end {}
}