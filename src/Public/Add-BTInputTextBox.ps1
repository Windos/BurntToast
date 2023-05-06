function Add-BTInputTextBox {
    <#
        .SYNOPSIS
        Add a text box for input to a toaster notification.

        .DESCRIPTION
        The Add-BTInputTextBox function adds a text box for user input to the body of a toast notification.

        You can include a title, which is displayed above the text box, and placeholder text which is displayed when the text box is empty.

        Up to five text boxes can be added to a toast notification.

        .INPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder. You can pipe a toast content builder object to Add-BTInputTextBox.

        .OUTPUTS
        None. The Add-BTInputTextBox function does not provide any output by default.

        You can optionally use the PassThru parameter to output the updated toast content builder object, which enables chaining functions together.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTAppLogo -ContentBuilder $Builder

        PS C:\>Add-BTInputTextBox -ContentBuilder $Builder -Id 'Example 01'

        This example adds a text box to a toast notification, specifying the toast content builder object via a parameter on the function.

        It also adds an app logo to the toast notification to ensure that the text box is displayed.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo

        PS C:\>$Builder | Add-BTInputTextBox -Id 'Example 02'

        This example adds a text box to a toast notification, specifying the toast content builder object via the pipeline

        It also adds an app logo to the toast notification to ensure that the text box is displayed.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo

        PS C:\>$Builder | Add-BTInputTextBox -Id 'Example 03' -Title "Enter your name" -PlaceholderContent "John Doe"

        This example adds a text box to a toast notification, specifying the toast content builder object via the pipeline.

        The text box will be displayed with a title above it and placeholder text to help indicate what the user should enter.

        It also adds an app logo to the toast notification to ensure that the text box is displayed.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo

        PS C:\>$Builder | Add-BTInputTextBox -Id 'Example 04' -PlaceholderContent "Enter your name" -DefaultContent "John Doe"

        This example adds a text box to a toast notification, specifying the toast content builder object via the pipeline.

        The text box will have the default text "John Doe" when the toast is shown, and will have the placeholder text "Enter your name" if the default text is removed by the user.

        It also adds an app logo to the toast notification to ensure that the text box is displayed.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo

        PS C:\>$Builder | Add-BTInputTextBox -Id 'Example 05 - First Name' -Title 'Set your name' -PlaceholderContent "Enter your first name" -DefaultContent "John"

        PS C:\>$Builder | Add-BTInputTextBox -Id 'Example 05 - Last Name' -PlaceholderContent "Enter your last name" -DefaultContent "Doe"

        This example adds a text box to a toast notification, specifying the toast content builder object via the pipeline.

        The text box will have the default text "John Doe" when the toast is shown, and will have the placeholder text "Enter your name" if the default text is removed by the user.

        It also adds an app logo to the toast notification to ensure that the text box is displayed.

        .NOTES
        You cannot create a toast notification with only text boxes, as they are only displayed when some other element has been added to the toast notification such as an app logo, text, or image.

        .LINK
        https://docs.toastit.dev/commands/add-btinputtextbox
    #>

    [CmdletBinding()]
    param (
        # The toast content builder object that represents the toast notification being constructed.
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder] $ContentBuilder,

        # ID used to identify a specific text box.
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        # Title text to display above the element.
        [string] $Title,

        # Placeholder text to be displayed on the text box when the user hasn't typed any text yet.
        # If this is used with the DefaultContent parameter, this content will only be displayed if the default content is removed.
        [string] $PlaceholderContent,

        # The default text in the text box.
        [string] $DefaultContent,

        # Returns an object that represents the item with which you're working. By default, this cmdlet doesn't generate any output.
        [switch] $PassThru
    )

    begin {}
    process {
        $ToastTextBox = [Microsoft.Toolkit.Uwp.Notifications.ToastTextBox]::new($Id)

        if ($null -ne $Title) {
            $ToastTextBox.Title = $Title
        }

        if ($null -ne $PlaceholderContent) {
            $ToastTextBox.PlaceholderContent = $PlaceholderContent
        }

        if ($null -ne $DefaultContent) {
            $ToastTextBox.DefaultInput = $DefaultContent
        }

        try {
            $null = $ContentBuilder.AddToastInput($ToastTextBox)
        } catch {
            Write-Warning ('The max number of text and selection boxes (5) on the toast notification has been reached. ' +
                'You cannot add any more input boxes.')
        }

        if ($PassThru) {
            $ContentBuilder
        }
    }
    end {}
}