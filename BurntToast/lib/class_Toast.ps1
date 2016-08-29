class Toast
{
    [Visual] $Visual
    [Scenario] $Scenario
    [Audio] $Audio
    [Actions] $Actions
    [Duration] $Duration

    Toast ([Visual] $Visual)
    {
        $this.Visual = $Visual
    }

    Toast ([Visual] $Visual, [Duration] $Duration)
    {
        $this.Visual = $Visual
        $this.Duration = $Duration
    }

    Toast ([Visual] $Visual, [Audio] $Audio)
    {
        $this.Visual = $Visual
        $this.Audio = $Audio
    }

    Toast ([Visual] $Visual, [Audio] $Audio, [Duration] $Duration)
    {
        $this.Visual = $Visual
        $this.Audio = $Audio
        $this.Duration = $Duration
    }
    
    Toast ([Scenario] $Scenario, [Visual] $Visual)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
    }

    Toast ([Scenario] $Scenario, [Visual] $Visual, [Duration] $Duration)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Duration = $Duration
    }

    Toast ([Scenario] $Scenario, [Visual] $Visual, [Audio] $Audio)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Audio = $Audio
    }

    Toast ([Scenario] $Scenario, [Visual] $Visual, [Audio] $Audio, [Duration] $Duration)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Audio = $Audio
        $this.Duration = $Duration
    }

    Toast ([Visual] $Visual, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Actions = $Actions
    }

    Toast ([Visual] $Visual, [Duration] $Duration, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Duration = $Duration
        $this.Actions = $Actions
    }

    Toast ([Visual] $Visual, [Audio] $Audio, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Audio = $Audio
        $this.Actions = $Actions
    }

    Toast ([Visual] $Visual, [Audio] $Audio, [Duration] $Duration, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Audio = $Audio
        $this.Duration = $Duration
        $this.Actions = $Actions
    }
    
    Toast ([Scenario] $Scenario, [Visual] $Visual, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Actions = $Actions
    }

    Toast ([Scenario] $Scenario, [Visual] $Visual, [Duration] $Duration, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Duration = $Duration
        $this.Actions = $Actions
    }

    Toast ([Scenario] $Scenario, [Visual] $Visual, [Audio] $Audio, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Audio = $Audio
        $this.Actions = $Actions
    }

    Toast ([Scenario] $Scenario, [Visual] $Visual, [Audio] $Audio, [Duration] $Duration, [Actions] $Actions)
    {
        $this.Visual = $Visual
        $this.Scenario = $Scenario
        $this.Audio = $Audio
        $this.Duration = $Duration
        $this.Actions = $Actions
    }

    [xml] GetXML ()
    {
        $ToastXML = New-Object System.XML.XMLDocument
        $ToastElement = $ToastXML.CreateElement('toast')

        $ToastElement.SetAttribute('scenario', $this.Scenario)
        $ToastElement.SetAttribute('duration', $this.Scenario)
        
        $VisualXML = $ToastXML.ImportNode($this.Visual.GetXML().DocumentElement, $true)
        $ToastElement.AppendChild($VisualXML)

        if ($this.Audio)
        {
            $AudioXML = $ToastXML.ImportNode($this.Audio.GetXML().DocumentElement, $true)
            $ToastElement.AppendChild($AudioXML)
        }

        if ($this.Actions)
        {
            $ActionsXML = $ToastXML.ImportNode($this.Actions.GetXML().DocumentElement, $true)
            $ToastElement.AppendChild($ActionsXML)
        }

        $ToastXML.AppendChild($ToastElement)

        return $ToastXML
    }
}
