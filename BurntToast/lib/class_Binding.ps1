class Binding
{
    static [string] $Template = 'ToastGeneric'
    [object[]] $Element = @()

    Binding () {}

    [void] AddElement ([Text] $Element)
    {
        $this.Element += $Element
    }

    [void] AddElement ([Image] $Element)
    {
        $this.Element += $Element
    }
    
    [xml] GetXML ()
    {
        $BindingXML = New-Object System.XML.XMLDocument
        $BindingElement = $BindingXML.CreateElement('binding')
        $BindingElement.SetAttribute('template', [Binding]::Template)
        
        foreach ($Element in $this.Element)
        {
            $ElementXML = $BindingXML.ImportNode($Element.GetXML().DocumentElement, $true)
            $BindingElement.AppendChild($ElementXML)
        }

        $BindingXML.AppendChild($BindingElement)

        return $BindingXML
    }
}
