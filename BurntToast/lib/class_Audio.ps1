class Audio
{
    [AudioSource] $Source
    [string] $Path
    [boolean] $Loop
    [boolean] $Silent

    Audio ([AudioSource] $Source)
    {
        if ($Source -like 'Call*' -or $Source -like 'Alarm*')
        {
            $this.Loop = $true
        }

        $this.Source = $Source
        $this.Silent = $false
    }

    Audio ([String] $Path)
    {
        $this.Loop = $true
        $this.Path = $Path
        $this.Silent = $false
    }

    Audio ([Boolean] $Silent)
    {
        $this.Silent = $true
    }

    Audio ()
    {
        $this.Source = [AudioSource]::Default
        $this.Loop = $false
        $this.Silent = $false
    }

    [xml] GetXML ()
    {
        $AudioXML = New-Object System.XML.XMLDocument
        $AudioElement = $AudioXML.CreateElement('audio')

        if ($this.Silent)
        {
            $AudioElement.SetAttribute('silent','true')
        }
        else
        {
            if (!$this.Path)
            {
                $src = 'ms-winsoundevent:Notification.'
                
                if ($this.Source -like 'Call*' -or $this.Source -like 'Alarm*')
                {
                    $src += 'Looping.'
                }

                $src += $this.Source
            }
            else
            {
                $src = "file:///$($this.Path)"
            }

            $AudioElement.SetAttribute('src',$src)

            if ($this.Loop)
            {
                $AudioElement.SetAttribute('loop','true')
            }
        }

        $AudioXML.AppendChild($AudioElement)
        return $AudioXML
    }
}
