function Add-BTDataBinding {
    <#
        .SYNOPSIS
        Add Data Binding key value pairs to a toast content builder.

        .DESCRIPTION
        The Add-BTDataBinding function adds Data Binding key value pairs to a toast content builder.

        You can provide these as individual pairs via the `Key` and `Value` parameters or you can add multiple pairs via a hashtable.

        If the key appears in a bindable string, it will be replaced by the value.

        .INPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder. You can pipe a toast content builder object to Add-BTDataBinding.

        .OUTPUTS
        None. The Add-BTDataBinding function does not provide any output by default.

        You can optionally use the PassThru parameter to output the updated toast content builder object, which enables chaining functions together.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTText -ContentBuilder $Builder -Text 'Heading' -Bindable

        PS C:\>Add-BTText -ContentBuilder $Builder -Text 'Body' -Bindable

        PS C:\>Add-BTDataBinding -ContentBuilder $Builder -Key 'Heading' -Value 'This is the heading'

        PS C:\>Add-BTDataBinding -ContentBuilder $Builder -Key 'Body' -Value 'This is the body'

        PS C:\>Show-BTNotification -ContentBuilder $Builder

        This example adds two text elements to the toast notification, both of which are bindable. It then adds two key value pairs to the toast notification, which will replace the bindable text elements.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTText -ContentBuilder $Builder -Text 'Heading' -Bindable

        PS C:\>Add-BTText -ContentBuilder $Builder -Text 'Body' -Bindable

        PS C:\>$Binding = @{Heading = 'This is the heading'; Body = 'This is the body'}

        PS C:\>Add-BTDataBinding -ContentBuilder $Builder -Hashtable $Binding

        PS C:\>Show-BTNotification -ContentBuilder $Builder

        This example adds two text elements to the toast notification, both of which are bindable. It then adds two key value pairs to the toast notification, which will replace the bindable text elements.

        .LINK
        https://docs.toastit.dev/commands/add-btdatabinding
    #>

    [CmdletBinding(DefaultParameterSetName = 'KeyValue')]
    param (
        # The toast content builder object that represents the toast notification being constructed.
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder] $ContentBuilder,

        # The key which indicates the bindable string to be replaced.
        [Parameter(Mandatory,
                   ParameterSetName = 'KeyValue')]
        [ValidateNotNullOrEmpty()]
        [string] $Key,

        # The value which will replace the key in the toast notification.
        [Parameter(Mandatory,
                   ParameterSetName = 'KeyValue')]
        [ValidateNotNullOrEmpty()]
        [string] $Value,

        # Allows to adding multiple key value pairs at once via a hash table.
        [Parameter(Mandatory,
                   ParameterSetName = 'Bulk')]
        [hashtable] $Hashtable,

        # Returns an object that represents the item with which you're working. By default, this cmdlet doesn't generate any output.
        [switch] $PassThru
    )

    begin {}
    process {
        if ($PSCmdlet.ParameterSetName -eq 'KeyValue') {
            $ContentBuilder.DataBinding[$Key] = $Value
        } else {
            foreach ($HashtableKey in $Hashtable.Keys) {
                $ContentBuilder.DataBinding[$HashtableKey] = $Hashtable[$HashtableKey]
            }
        }

        if ($PassThru) {
            $ContentBuilder
        }
    }
    end {}
}