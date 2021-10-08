. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTColumn' {
    Context 'via New-BurntToastNotification' {
        $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
        $ImagePath = Resolve-Path -Path (Join-Path $ModuleRoot 'Images\BurntToast.png')

        Start-Transcript tmp.log
        try {
            $TitleLabel = New-BTText -Text 'Title:' -Style Base
            $AlbumLabel = New-BTText -Text 'Album:' -Style Base
            $ArtistLabel = New-BTText -Text 'Artist:' -Style Base

            $Title = New-BTText -Text 'soft focus' -Style BaseSubtle
            $Album = New-BTText -Text 'Birocratic' -Style BaseSubtle
            $Artist = New-BTText -Text 'beets 4 (2017)' -Style BaseSubtle

            $Column1 = New-BTColumn -Children $TitleLabel, $AlbumLabel, $ArtistLabel -Weight 4
            $Column2 = New-BTColumn -Children $Title, $Album, $Artist -Weight 6

            New-BurntToastNotification -Text 'Now Playing' -Column $Column1, $Column2 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{Now Playing}</text><group><subgroup hint-weight=""4""><text hint-style=""base"">{Title:}</text><text hint-style=""base"">{Album:}</text><text hint-style=""base"">{Artist:}</text></subgroup><subgroup hint-weight=""6""><text hint-style=""baseSubtle"">{soft focus}</text><text hint-style=""baseSubtle"">{Birocratic}</text><text hint-style=""baseSubtle"">{beets 4 (2017)}</text></subgroup></group><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log | Should -Be $Expected
        }
    }
    Context 'via Submit-BTNotification' {
        Start-Transcript tmp.log
        try {
            $HeadingText = New-BTText -Text 'Now Playing'

            $TitleLabel = New-BTText -Text 'Title:' -Style Base
            $AlbumLabel = New-BTText -Text 'Album:' -Style Base
            $ArtistLabel = New-BTText -Text 'Artist:' -Style Base

            $Title = New-BTText -Text 'soft focus' -Style BaseSubtle
            $Album = New-BTText -Text 'Birocratic' -Style BaseSubtle
            $Artist = New-BTText -Text 'beets 4 (2017)' -Style BaseSubtle

            $Column1 = New-BTColumn -Children $TitleLabel, $AlbumLabel, $ArtistLabel -Weight 4
            $Column2 = New-BTColumn -Children $Title, $Album, $Artist -Weight 6

            $Binding1 = New-BTBinding -Children $HeadingText -Column $Column1, $Column2
            $Visual1 = New-BTVisual -BindingGeneric $Binding1
            $Content1 = New-BTContent -Visual $Visual1

            Submit-BTNotification -Content $Content1 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "Submit-BTNotification" on target "submitting: [ToastNotification] with AppId {1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe, Id , Sequence Number  and XML: <?xml version="1.0" encoding="utf-8"?><toast><visual><binding template="ToastGeneric"><text>{Now Playing}</text><group><subgroup hint-weight="4"><text hint-style="base">{Title:}</text><text hint-style="base">{Album:}</text><text hint-style="base">{Artist:}</text></subgroup><subgroup hint-weight="6"><text hint-style="baseSubtle">{soft focus}</text><text hint-style="baseSubtle">{Birocratic}</text><text hint-style="baseSubtle">{beets 4 (2017)}</text></subgroup></group></binding></visual></toast>".'
            $Log | Should -Be $Expected
        }
    }
}
