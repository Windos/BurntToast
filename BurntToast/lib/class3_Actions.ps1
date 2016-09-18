class Actions
{
    [string] $SystemCommand = 'SnoozeAndDismiss'
    [object[]] $Element = @()

    Actions () {}
    
    Actions ([string] $SystemCommand)
    {
        $this.SystemCommand = $SystemCommand
    }

    [void] AddElement ([ToastAction] $Element)
    {
        $this.Element += $Element
    }

    [xml] GetXML ()
    {
        $ActionsXML = New-Object System.XML.XMLDocument
        $ActionsElement = $ActionsXML.CreateElement('actions')

        if ($this.Element.Count -eq 0)
        {
            $ActionsElement.SetAttribute('hint-systemCommands', $this.SystemCommand)
        }
        else
        {
            foreach ($Element in $this.Element)
            {
                $ElementXML = $ActionsXML.ImportNode($Element.GetXML().DocumentElement, $true)
                $ActionsElement.AppendChild($ElementXML)
            }
        }

        $ActionsXML.AppendChild($ActionsElement)
        return $ActionsXML
    }
}
