class Visual
{
    [Binding] $Binding

    Visual ([Binding] $Binding)
    {
        $this.Binding = $Binding
    }
    
    [xml] GetXML ()
    {
        $VisualXML = New-Object System.XML.XMLDocument
        $VisualElement = $VisualXML.CreateElement('visual')
        
        $ElementXML = $VisualXML.ImportNode($this.Binding.GetXML().DocumentElement, $true)
        $VisualElement.AppendChild($ElementXML)

        $VisualXML.AppendChild($VisualElement)

        return $VisualXML
    }
}
