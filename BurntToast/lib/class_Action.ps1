class Action
{
    [string] $Content
    [string] $Arguments
    [ActivationType] $ActivationType
    [System.IO.Path] $ImageUri
    [string] $InputId

    Action ([string] $Content, [string] $Arguments)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
    }

    Action ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
    }

    Action ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType, [System.IO.Path] $ImageUri)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
        $this.ImageUri = $ImageUri
    }

    Action ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
        $this.InputId = $InputId
    }

    Action ([string] $Content, [string] $Arguments, [System.IO.Path] $ImageUri)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ImageUri = $ImageUri
    }

    Action ([string] $Content, [string] $Arguments, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.InputId = $InputId
    }

    Action ([string] $Content, [string] $Arguments, [System.IO.Path] $ImageUri, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ImageUri = $ImageUri
        $this.InputId = $InputId
    }

    Action ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType, [System.IO.Path] $ImageUri, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
        $this.ImageUri = $ImageUri
        $this.InputId = $InputId
    }

    [xml] GetXML ()
    {
        $ActionXML = New-Object System.XML.XMLDocument
        $ActionElement = $ActionXML.CreateElement('action')

        $ActionElement.SetAttribute('content', $this.Content)
        $ActionElement.SetAttribute('arguments', $this.Arguments)
        $ActionElement.SetAttribute('activationType', $this.ActivationType)

        if ($this.ImageUri)
        {
            $ActionElement.SetAttribute('imageUri', $this.ImageUri)
        }

        if ($this.InputId)
        {
            $ActionElement.SetAttribute('hint-inputId', $this.InputId)
        }

        $ActionXML.AppendChild($ActionElement)
        return $ActionXML
    }
}
