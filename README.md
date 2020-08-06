# BurntToast

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/828836a2a70b4c998de8127fd2150fbc)](https://www.codacy.com/app/Windos/BurntToast?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Windos/BurntToast&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/Windos/BurntToast/branch/master/graph/badge.svg)](https://codecov.io/gh/Windos/BurntToast)
[![Build Status](https://dev.azure.com/windosnz/BurntToast/_apis/build/status/Windos.BurntToast-Build?branchName=master)](https://dev.azure.com/windosnz/BurntToast/_build/latest?definitionId=2&branchName=master)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/BurntToast.svg)](https://www.powershellgallery.com/packages/BurntToast)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/BurntToast.svg)](https://www.powershellgallery.com/packages/BurntToast)
[![Open Issues](https://img.shields.io/github/issues-raw/Windos/BurntToast.svg)](https://github.com/Windos/BurntToast/issues)

![BurntToast Logo Banner](/Media/BurntToast-Wide.png)

PowerShell Module for displaying **Windows 10** Toast Notifications

## Install

### PowerShell Gallery Install (Requires PowerShell v5)

```powershell
    Install-Module -Name BurntToast
```

See the [PowerShell Gallery](http://www.powershellgallery.com/packages/BurntToast/) for the complete details and instructions.

### Manual Install

Download [BurntToast.zip](https://github.com/Windos/BurntToast/releases/download/v0.6.2/BurntToast.zip) and extract the contents into `$env:userprofile\Documents\WindowsPowerShell\modules\BurntToast` (you may have to create these directories if they don't exist.)

if you using Powershell 6 or later, extract into `$env:userprofile\Documents\PowerShell\Modules\BurntToast`

*Please remember to "**unblock**" the zip file before extracting the contents. Not doing so will result in the module not working correctly. This can be done via the file properties or with `Unblock-File`.*

## Examples

### [Default Toast](/Examples/Example01/)

```powershell
    New-BurntToastNotification
```

![BurntToast Notification Example Default](/Examples/Example01/Example1-Default.png)

### [Customized Toast](/Examples/Example02/)

```powershell
    New-BurntToastNotification -AppLogo C:\smile.jpg -Text "Don't forget to smile!",
                                                           'Your script ran successfully, celebrate!'
```

![BurntToast Notification Example Custom](/Examples/Example02/Example2-Custom.png)

### [Alarm Clock](/Examples/Example03/)

```powershell
    New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2' -SnoozeAndDismiss
```

![BurntToast Notification Example Alarm](/Examples/Example03/Example3-Alarm.png)

### [Engine Events](/Examples/Example04/)

```powershell
    Register-EngineEvent -SourceIdentifier Powershell.Exiting -Action {
        $Header = New-BTHeader -Id 1 -Title "Automation Done"
        New-BurntToastNotification -Text "Hey there! That script you wrote is finished." -Silent -Header $Header
    }
```

### [Toast Reminders](/Examples/Example05/)

*Find the `New-ToastReminder` function in the linked example*

```powershell
    New-ToastReminder -Minutes 30 -ReminderTitle 'Hey you' -ReminderText 'The coffee is brewed'
```

### [Toast Event Notifications](/Examples/Example06/)

```powershell
    $BurntJob = Start-Job -ScriptBlock {Start-Sleep 5;Get-date} -Name "BurntJob"

    $BurntEvent = Register-ObjectEvent $BurntJob StateChanged -Action {
        New-BurntToastNotification -Text "Job: $($BurntJob.Name) completed"
        $BurntEvent | Unregister-Event
    }
```

### [Toast Job Notifications](/Examples/Example07/)

```powershell
    $Destination = "8.8.8.8"
    $ScriptBlock = {
        $TimesLooped = 0
        while ( $Duration -le $TimesLooped) {
            if ( Test-Connection -ComputerName $using:Destination -Count 1 -Quiet ) {
                New-BurntToastNotification -Text ($using:Destination + " is online"), ("Last checked :" + (Get-Date).ToString())    -UniqueIdentifier $using:Destination
            }#if
            else {
                New-BurntToastNotification -Text ($using:Destination + " is offline"), ("Last checked :" + (Get-Date).ToString())   -UniqueIdentifier $using:Destination
            }#else
            Start-Sleep -Seconds 5
            $TimesLooped++
        }#while
    }#Scriptblock
    Start-Job -Name $Destination -ScriptBlock $ScriptBlock
```

[Toast Job Notification (gif)](/Examples/Example06/Example06_Get-ToastJobNotification.gif)

### [HTTP Listener](/Examples/Example08/)

![Example: API Call](/Examples/Example08/ApiToast.png)

### [Windows 10 Shoulder Tap Notification](/Examples/Example10)

```powershell
$Image = 'https://i.imgur.com/WKiNp5o.gif'
$Contact = 'stormy@example.com'
$Text = 'First Shoulder Tap', 'This is for the fallback toast.'

New-BurntToastShoulderTap -Image $Image -Person $Contact -Text $Text
```

![Example: Shoulder Tap feature in Windows 10](/Examples/Example10/result.gif)

## Releases

**Please note:** as of v0.5.0, BurntToast no longer works on Windows 8.

- [Bleeding Edge](https://github.com/Windos/BurntToast/archive/v0.7.2.zip) (Development/Raw Repo)

- [v0.7.2](https://github.com/Windos/BurntToast/releases/download/v0.7.2/BurntToast.zip)

  - Fix: Curly Braces when "Reminder" pops up ([#72](https://github.com/Windos/BurntToast/issues/72))

  - Fix: Caching remote gifs are saved based on their remote filename and not overwritten ([#105](https://github.com/Windos/BurntToast/issues/105))

    - Thanks [@KelvinTegelaar](https://github.com/KelvinTegelaar)

  - Fix: BurntToast and .NET 5 ([#101](https://github.com/Windos/BurntToast/issues/101))

- [v0.7.1](https://github.com/Windos/BurntToast/releases/download/v0.7.1/BurntToast.zip)

  - Update: Microsoft Community Toolkit to 6.0.0

  - New: Support relative paths on images

  - New: "ScheduledToast" switch added to `Get-BTHistory` which returns scheduled or snoozed toast notifications

  - Enhancement: Libraries only loaded on module import if libraries not already loaded

  - Enhancement: Validate that image paths exist

  - Fix: Reverted to XML clean up to remove curly braces if databindings are not being used (Issue #72)

  - Known Issues:

    - Regardless of what snooze option is chosen, a snoozed toast will re-appear after 9 minutes
    - Cause is unknown and isn''t unique to v0.7.1, will be investigated while working on v0.7.2

- [v0.7.0](https://github.com/Windos/BurntToast/releases/download/v0.7.0/BurntToast.zip)

  - **HEADLINE FEATURE**: My People "Shoulder Tap" notifications have been implemented

  - You can now specify images on the network via UNC paths. Fix for #56

  - We're now properly supporting bindable text, and removing the curly braces more gracefully.

  - Get a list of all toasts you've sent, which have not been dismissed by the user, using `Get-BTHistory`.

  - Remove toasts you've sent, using `Remove-BTNotification`.

  - Set expiration times on toasts using the new `ExpirationTime` parameter on `New-BurntToastNotification` and `Submit-BTNotification`.

    - Toasts which have expired are removed from the Action Center.

  - Send toasts directly to the Action Center, and avoid showing them on screen, with the new `SuppressPopup` switch on `New-BurntToastNotification` and `Submit-BTNotification`.

  - You can now adjust a toasts timestamp (both past and future) using the `CustomTimestamp` parameter on `New-BurntToastNotification` and `New-BTContent`.

    - If not specified, the system uses the time at which the toast was received and this may not accuratly reflect the intent of the notification.

- [v0.6.3](https://github.com/Windos/BurntToast/releases/download/v0.6.3/BurntToast.zip)

  - Update Windows Community Toolkit (UWP Notifications) to 5.0.0.

    - Also switched to the UAP variant, as the .NET Standard one was causing issues for some users.

  - (BACKEND) Implemented CI pester tests on Azure DevOps Pipelines, including code coverage stats.

  - Fixed style issues flagged by Codacy, mainly Markdown headers.

  - Added WhatIf support to all functions, laying ground work for expanded (read: any) Pester tests.

  - Functions all in .psm1 now, instead of separate .ps1 files. SPEED!

- [v0.6.2](https://github.com/Windos/BurntToast/releases/download/v0.6.2/BurntToast.zip)

  - Updated UWP Toolkit to 2.2.0

  - Fixed an issue with sound looping

  - New-BurntToastNotification now accepts multiple ProgressBar objects

  - Fixed Issue #28, ProgressBars should now work for all locales

  - Fixed Issue #18, Images from the internet will now be downloaded locally

    - Supports regular images, hero images, and applogo

  - All functions now included in .psm1 for release (Thanks @chrislgardner)

- [v0.6.1](https://github.com/Windos/BurntToast/releases/download/v0.6.1/BurntToast.zip)

  - Customizable AppId removed from the New-BurntToastNotification function as a quick fix for Fall Creators Update.

    - If you''re using a customized AppId and are not upgrading to the Fall Creators Update, then stay on version 0.6.0.

  - Default AppId changed to match PowerShell.exe.

  - Registry entry for AppId is now automatically created when the module loads.

  - Included UWPCommunityToolkit library updated to v2.0.0.

- [v0.6.0](https://github.com/Windos/BurntToast/releases/download/v0.6.0/BurntToast.zip)

  - Updated bundled UWP Toolkit to 1.4.1

    - Note that this caused an issue where strings were being wrapped with curly braces in end results. A workaround has been implemented, but could mean that if you legitimately use some rather obscure strings, they may have the braces removed.

  - Hero Images working now (Thanks to Creators Update)

  - Headers can now be included (Creators Update feature)

  - Progress bars can now be included (Creators Update feature)

  - Specify a unique identifier in order to replace existing toasts

  - You can specify a custom sound file using the -Path parameter of the New-BTAudio function. This hasn''t been exposed through the main function... that poor thing is getting bloated.

  - There is now help for every public function, and the online version for each of them can be found on github. Specify the -Online switch when using Get-Help to be taken directly there.

- [v0.5.2](https://github.com/Windos/BurntToast/releases/download/v0.5.2/BurntToast.zip)

  - Exposed ability to have custom buttons via New-BurntToastNotification, passing result from New-BTButton to the -Button parameter.

    - Expect a blog post soon covering some cool ways to use these buttons. Keep an eye out on [king.geek.nz](http://king.geek.nz).

  - Fixed module commands not auto-loading by removing Basic/Advanced function designation ( :( ).

  - Help created for New-BTButton, and the function has had a pass to ensure it works as per the community toolkit.

  - Help completed for New-BurntToastNotification, and Toast alias now exporting correctly.

- [v0.5.1](https://github.com/Windos/BurntToast/releases/download/v0.5.1/BurntToast.zip)

  - Small bug fixes (thanks for opening issues!)
  - Confirmed: Now **ONLY** works on Windows 10
  - BurntToast now has its own, original, logo!
  - New public function to adjust function level of module: Set-BTFunctionLevel
  - Implemented checking for and registering of AppId in the registry to ensure proper Toast behaviour in the Action Center

- [v0.5.0](https://github.com/Windos/BurntToast/releases/download/v0.5.0/BurntToast.zip)

  - Converted to using the UWP Community Toolkit.
  - Snooze and Dismiss now available and working.
  - Documentation is out of date, this will be polished in the next release.

- [v0.4.0](https://github.com/Windos/BurntToast/releases/download/v0.4.0/BurntToast.zip) - Last version that supports Windows 8

  - Credential parameter added so toasts can be generated for regular user when running PowerShell host as a different (e.g. Admin) account.

- [v0.3.0](https://github.com/Windos/BurntToast/releases/download/v0.3.0/BurntToast.zip)

  - Help has been added
  - Toasts can be silent with -Silent switch
  - General bug fixes

- [v0.2.0](https://github.com/Windos/BurntToast/releases/download/v0.2.0/BurntToast.zip)

- [v0.1.0](https://github.com/Windos/BurntToast/releases/download/v0.1.0/BurntToast.zip)

## Contributors

- [Windos](https://github.com/Windos)

## TODO

- see [TODO](TODO.md) file

## License

- see [LICENSE](LICENSE.md) file

## Image Credit

The [default image](BurntToast.png) for BurntToast Notifications is a photo taken by [Craig Sunter](https://www.flickr.com/photos/16210667@N02/17230428864)

## Contact

- Twitter: [@WindosNZ](https://twitter.com/windosnz)
- Blog: [king.geek.nz](https://king.geek.nz/)
