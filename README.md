# BurntToast

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/5c96b736ff1b45d98666160ab37dcad5)](https://www.codacy.com/manual/Windos/BurntToast?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Windos/BurntToast&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/Windos/BurntToast/branch/main/graph/badge.svg)](https://codecov.io/gh/Windos/BurntToast)
[![Build Status](https://dev.azure.com/windosnz/BurntToast/_apis/build/status/Windos.BurntToast-Build?branchName=main)](https://dev.azure.com/windosnz/BurntToast/_build/latest?definitionId=2&branchName=main)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/BurntToast.svg)](https://www.powershellgallery.com/packages/BurntToast)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/BurntToast.svg)](https://www.powershellgallery.com/packages/BurntToast)
[![Open Issues](https://img.shields.io/github/issues-raw/Windos/BurntToast.svg)](https://github.com/Windos/BurntToast/issues)

![BurntToast Logo Banner](/Media/BurntToast-Wide.png)

PowerShell Module for displaying **Windows 10** and **Windows Server 2019** Toast Notifications

## ❗❗❗ NOTICE ❗❗❗

BurntToast v1.0.0 will include **numerous** breaking changes and your existing scripts **will not** work without changes.

**DO NOT** upgrade to BurntToast v1.0.0 until you are ready.

You can read more about the up coming changes on [ToastIT.dev](https://toastit.dev/tag/burnttoast/) and BurntToast's new [Docs Site](https://docs.toastit.dev/changelog)

## Install

### PowerShell Gallery Install (Requires PowerShell v5)

```powershell
Install-Module -Name BurntToast
```

See the [PowerShell Gallery](http://www.powershellgallery.com/packages/BurntToast/) for the complete details and instructions.
Don't forget to set the correct [Execution Policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.1).

### Manual Install

Download [BurntToast.zip](https://github.com/Windos/BurntToast/releases/latest/download/BurntToast.zip) from [Releases page](https://github.com/Windos/BurntToast/releases/latest) and extract the contents into `$env:userprofile\Documents\WindowsPowerShell\modules\BurntToast` (you may have to create these directories if they don't exist.)

If you are using PowerShell 6 or later, extract into `$env:userprofile\Documents\PowerShell\Modules\BurntToast`

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

- [0.8.5](https://github.com/Windos/BurntToast/releases/download/v0.8.5/BurntToast.zip)

  - Actually implement the ability to use a UniqueIdentifier with the Remove-BTNotification function (which was half implemented in 0.8.4)

- [0.8.4](https://github.com/Windos/BurntToast/releases/download/v0.8.4/BurntToast.zip)

  - Enhancement: Header ID on New-BTHeader is now optional. An ID will be auto generated if not specified ([#125](https://github.com/Windos/BurntToast/issues/125))

    - Thanks [@glennsarti](https://github.com/glennsarti)

  - Enhancement: Hero images can now be specified using the New-BurntToastNotification function using the -HeroImage parameter ([#80](https://github.com/Windos/BurntToast/issues/80))

    - Thanks [@UniverseCitiz3n](https://github.com/UniverseCitiz3n)

  - Enhancement: AppIDs can now be specified using the New-BurntToastNotification function using the -AppId parameter.

    - Thanks [@cedarbaum](https://github.com/cedarbaum)

  - Enhancement: You can now specify a UniqueIdentifier when using the Remove-BTNotification function rather than component Tag and Group strings.

  - Fix: Weird edge cases when taking text from Twitch/IRC and using them in a toast is now sorted.

    - Thanks [@potatoqualitee](https://github.com/potatoqualitee) and [@vexx32](https://github.com/vexx32)

- [0.8.3](https://github.com/Windos/BurntToast/releases/download/v0.8.3/BurntToast.zip)

  - Fix: Error when running Update-BTNotification on PowerShell 6.0+ ([#120](https://github.com/Windos/BurntToast/issues/120))

  - Fix: Error when using actionable toast parameters on any version ([#122](https://github.com/Windos/BurntToast/issues/122))

  - Fix: Multiple warnings about events not being supported when specifying multiple event types.

- [v0.8.2](https://github.com/Windos/BurntToast/releases/download/v0.8.2/BurntToast.zip)

  - Add: AdaptiveGroups are now usable via New-BTColumn

- [v0.8.1](https://github.com/Windos/BurntToast/releases/download/v0.8.1/BurntToast.zip)

  - Fix: Toast alias removed in 0.8.0 has been restored

  - Deprecation: Signalling removal of Shoulder Tap cmdlets in future version, v0.9.0

  - Deprecation: Signalling removal of Path parameter from New-BTAudio in future version, v0.9.0.

    - See [MicrosoftDocs/windows-uwp Issue #1593](https://github.com/MicrosoftDocs/windows-uwp/issues/1593)

- [v0.8.0](https://github.com/Windos/BurntToast/releases/download/v0.8.0/BurntToast.zip)

  - Fix: Images from UNC path failing ([#111](https://github.com/Windos/BurntToast/issues/111))

  - Add: Ability to force a refresh of cached images via IgnoreCache switch on New-BTImage

  - Add: ACTIONABLE NOTIFICATIONS! Exposed via ActivatedAction and DismissedAction parameters on Submit-BTNotification and New-BurntToastNotification

- [v0.7.2](https://github.com/Windos/BurntToast/releases/download/v0.7.2/BurntToast.zip)

  - Fix: Curly Braces when "Reminder" pops up ([#72](https://github.com/Windos/BurntToast/issues/72))

  - Fix: Caching remote gifs are saved based on their remote filename and not overwritten ([#105](https://github.com/Windos/BurntToast/issues/105))

    - Thanks [@KelvinTegelaar](https://github.com/KelvinTegelaar)

  - Fix: BurntToast and .NET 5 ([#101](https://github.com/Windos/BurntToast/issues/101))

- see more in the [Full Change Log](CHANGES.md)

## Contributors

- [Windos](https://github.com/Windos)
- [jeremytbrun](https://github.com/jeremytbrun)
- [KelvinTegelaar](https://github.com/KelvinTegelaar)
- [steviecoaster](https://github.com/steviecoaster)
- [glennsarti](https://github.com/glennsarti)
- [UniverseCitiz3n](https://github.com/UniverseCitiz3n)
- [cedarbaum](https://github.com/cedarbaum)

## License

- See [LICENSE](LICENSE) file

## Image Credit

The [default image](/Media/BurntToast.png) for BurntToast Notifications is a photo taken by [Craig Sunter](https://www.flickr.com/photos/16210667@N02/17230428864)

## Contact

- Twitter: [@WindosNZ](https://twitter.com/windosnz)
- Blog: [ToastIT.dev](https://toastit.dev/)
