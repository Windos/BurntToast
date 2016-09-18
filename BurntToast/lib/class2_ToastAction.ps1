class ToastAction
{
    [string] $Content
    [string] $Arguments
    [ActivationType] $ActivationType
    [System.IO.Path] $ImageUri
    [string] $InputId

    ToastAction ([string] $Content, [string] $Arguments)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
    }

    ToastAction ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
    }

    ToastAction ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType, [System.IO.Path] $ImageUri)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
        $this.ImageUri = $ImageUri
    }

    ToastAction ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
        $this.InputId = $InputId
    }

    ToastAction ([string] $Content, [string] $Arguments, [System.IO.Path] $ImageUri)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ImageUri = $ImageUri
    }

    ToastAction ([string] $Content, [string] $Arguments, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.InputId = $InputId
    }

    ToastAction ([string] $Content, [string] $Arguments, [System.IO.Path] $ImageUri, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ImageUri = $ImageUri
        $this.InputId = $InputId
    }

    ToastAction ([string] $Content, [string] $Arguments, [ActivationType] $ActivationType, [System.IO.Path] $ImageUri, [string] $InputId)
    {
        $this.Content = $Content
        $this.Arguments = $Arguments
        $this.ActivationType = $ActivationType
        $this.ImageUri = $ImageUri
        $this.InputId = $InputId
    }

    [xml] GetXML ()
    {
        $ToastActionXML = New-Object System.XML.XMLDocument
        $ToastActionElement = $ToastActionXML.CreateElement('action')

        $ToastActionElement.SetAttribute('content', $this.Content)
        $ToastActionElement.SetAttribute('arguments', $this.Arguments)
        $ToastActionElement.SetAttribute('activationType', $this.ActivationType)

        if ($this.ImageUri)
        {
            $ToastActionElement.SetAttribute('imageUri', $this.ImageUri)
        }

        if ($this.InputId)
        {
            $ToastActionElement.SetAttribute('hint-inputId', $this.InputId)
        }

        $ToastActionXML.AppendChild($ToastActionElement)
        return $ToastActionXML
    }
}
