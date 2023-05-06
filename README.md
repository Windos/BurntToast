# BurntToast

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/5c96b736ff1b45d98666160ab37dcad5)](https://www.codacy.com/manual/Windos/BurntToast?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Windos/BurntToast&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/Windos/BurntToast/branch/main/graph/badge.svg)](https://codecov.io/gh/Windos/BurntToast)
[![Build Status](https://dev.azure.com/windosnz/BurntToast/_apis/build/status/Windos.BurntToast-Build?branchName=main)](https://dev.azure.com/windosnz/BurntToast/_build/latest?definitionId=2&branchName=main)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/BurntToast.svg)](https://www.powershellgallery.com/packages/BurntToast)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/BurntToast.svg)](https://www.powershellgallery.com/packages/BurntToast)
[![Open Issues](https://img.shields.io/github/issues-raw/Windos/BurntToast.svg)](https://github.com/Windos/BurntToast/issues)

![BurntToast Logo Banner](/images/BurntToast-Wide.png)

PowerShell Module for displaying **Windows 10** and **Windows Server 2019** Toast Notifications.

## Install

### PowerShell Gallery Install (Requires PowerShell v5)

```powershell
Install-Module -Name BurntToast
```

See the [PowerShell Gallery](http://www.powershellgallery.com/packages/BurntToast/) for the complete details and
instructions.

### Chocolatey

```powershell
choco install burnttoast-psmodule
```

See the [Chocolatey community package](https://chocolatey.org/packages/burnttoast-psmodule) for more details. Thanks
[Bill Curran](https://github.com/bcurran3) for maintaining the package.

## Releases

**Please note:** in v1.0.0 there are major breaking changes meaning you should not upgrade without understanding the
new usage paradigms. Existing scripts will **NOT** work without substantial changes.

### [v1.0.0-Preview2](https://github.com/Windos/BurntToast/releases/download/v1.0.0-Preview2/BurntToast.zip)

### Breaking Changes

- Consolidated multiple image functions into one function, Add-BTImage.

  - Add-BTAppLogo and Add-BTHeroImage have been removed and their functionality added to Add-BTImage.

### Features

- Added Attribution switch to Add-BTText, allowing addition of attribution text to a toast notification.

- Added Bindable switch to Add-BTText, allowing addition of bindable string to a toast notification that can be dynamically updated via data binding.

- Added Add-BTDataBinding function, allows for the addition of data binding key value pairs to a toast content builder for use in tandem with bindable strings.

- Added Add-BTInputTextBox function, allowing addition of text boxes.

### Improvements

- Ensure all invalid characters are removed from potential file system paths when caching images (thanks @markekraus)

### Libraries

- Microsoft.Windows.SDK.NET.Ref libraries bumped to 10.0.22621.28
- Microsoft.Toolkit.Uwp.Notifications libraries bumped to 7.1.3

### [v1.0.0-Preview1](https://github.com/Windos/BurntToast/releases/download/v1.0.0-Preview1/BurntToast.zip)

#### Breaking Changes

- Began rewriting module making use of Toast Content Builder objects. Available functions in Preview1 include:

  - Add-BTAppLogo

  - Add-BTHeroImage

  - Add-BTImage

  - Add-BTText

  - New-BTContentBuilder

  - Show-BTNotification

#### Libraries

- Microsoft.Windows.SDK.NET.Ref libraries bumped to 10.0.22000.22

- Microsoft.Toolkit.Uwp.Notifications library bumped to 7.1.2

### See more in the [Full Change Log](CHANGES.md)

## Contributors

- [Windos](https://github.com/Windos)
- [jeremytbrun](https://github.com/jeremytbrun)
- [KelvinTegelaar](https://github.com/KelvinTegelaar)
- [steviecoaster](https://github.com/steviecoaster)
- [glennsarti](https://github.com/glennsarti)
- [UniverseCitiz3n](https://github.com/UniverseCitiz3n)
- [cedarbaum](https://github.com/cedarbaum)

## License

- see [LICENSE](LICENSE) file

## Image Credit

The [default image](/images/BurntToast.png) for BurntToast Notifications is a photo taken by
[Craig Sunter](https://www.flickr.com/photos/16210667@N02/17230428864)

## Contact

- Twitter: [@WindosNZ](https://twitter.com/windosnz)
- Blog: [ToastIT.dev](https://toastit.dev/)
