class Image
{
    [string] $Source
    [ImagePlacement] $Placement
    [string] $Alt
    [ImageCrop] $Crop

    Image ([String] $Source)
    {
        $this.Source = $Source
    }

    Image ([String] $Source, [string] $Alt)
    {
        $this.Source = $Source
        $this.Alt = $Alt
    }

    Image ([String] $Source, [ImagePlacement] $Placement)
    {
        $this.Source = $Source
        $this.Placement = $Placement
    }

    Image ([String] $Source, [ImagePlacement] $Placement, [ImageCrop] $Crop)
    {
        $this.Source = $Source
        $this.Placement = $Placement
        $this.Crop = $crop
    }

    Image ([String] $Source, [string] $Alt, [ImagePlacement] $Placement)
    {
        $this.Source = $Source
        $this.Alt = $Alt
        $this.Placement = $Placement
    }

    Image ([String] $Source, [string] $Alt, [ImagePlacement] $Placement, [ImageCrop] $Crop)
    {
        $this.Source = $Source
        $this.Alt = $Alt
        $this.Placement = $Placement
        $this.Crop = $crop
    }

    [xml] GetXML ()
    {
        $ImageXML = New-Object System.XML.XMLDocument
        $ImageElement = $ImageXML.CreateElement('image')

        $ImageElement.SetAttribute('src',$this.Source)

        if ($this.Alt)
        {
            $ImageElement.SetAttribute('alt',$this.Alt)
        }
        
        $ImageElement.SetAttribute('placement',$this.Placement)
        $ImageElement.SetAttribute('hint-crop',$this.Crop)
        
        $ImageXML.AppendChild($ImageElement)
        return $ImageXML
    }
}
