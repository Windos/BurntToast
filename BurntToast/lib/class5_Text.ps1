class Text
{
    [string] $Content
    [boolean] $Empty

    Text ([string] $Content)
    {
        $this.Content = $Content
    }

    Text ([boolean] $Empty)
    {
        if ($Empty)
        {
            $this.Empty = $Empty
        }
        else
        {
            throw 'Don''t set the empty property to false, instead provide content.'
        }
    }

    Text ()
    {
        $this.Empty = $true
    }

    [xml] GetXML ()
    {
        $TextXML = New-Object System.XML.XMLDocument
        $TextElement = $TextXML.CreateElement('text')

        if (!$this.Empty)
        {
            $TextElement.InnerText = $this.Content
        }

        $TextXML.AppendChild($TextElement)
        return $TextXML
    }
}
