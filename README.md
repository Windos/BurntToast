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

- see more in the [Full Change Log](CHANGES.md)

## Contributors

- [Windos](https://github.com/Windos)
- [jeremytbrun](https://github.com/jeremytbrun)
- [KelvinTegelaar](https://github.com/KelvinTegelaar)

## License

- see [LICENSE](LICENSE.md) file

## Image Credit

The [default image](BurntToast.png) for BurntToast Notifications is a photo taken by [Craig Sunter](https://www.flickr.com/photos/16210667@N02/17230428864)

## Contact

- Twitter: [@WindosNZ](https://twitter.com/windosnz)
- Blog: [ToastIT.dev](https://toastit.dev/)
