![BurntToast Logo Banner](/Media/BurntToast-Wide.png)

PowerShell Module for displaying **Windows 10** Toast Notifications

## Install

### PowerShell Gallery Install (Requires PowerShell v5)

    Install-Module -Name BurntToast

See the [PowerShell Gallery](http://www.powershellgallery.com/packages/BurntToast/) for the complete details and instructions.

### Manual Install

Download [BurntToast.zip](https://github.com/Windos/BurntToast/releases/download/v0.5.1/BurntToast.zip) and extract the contents into `C:\Users\[User]\Documents\WindowsPowerShell\modules\BurntToast` (you may have to create these directories if they don't exist.)

## Examples

### Default Toast

    New-BurntToastNotification

![BurntToast Notification Example Default](/Media/Example1-Default.png)

### Customized Toast

    New-BurntToastNotification -Text "Don't forget to smile!", 'Your script ran successfully, celebrate!' -AppLogo C:\smile.jpg

![BurntToast Notification Example Custom](/Media/Example2-Custom.png)

### Alarm Clock

    New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2' -SnoozeAndDismiss

![BurntToast Notification Example Alarm](/Media/Example3-Alarm.png)

## Releases

**Please note:** as of v0.5.0, BurntToast no longer works on Windows 8.

* [Bleeding Edge](https://github.com/Windos/BurntToast/archive/v0.5.2.zip) (Development/Raw Repo - **CAUTION**)
* [v0.6.0](https://github.com/Windos/BurntToast/releases/download/v0.6.0/BurntToast.zip)
    *
* [v0.5.2](https://github.com/Windos/BurntToast/releases/download/v0.5.2/BurntToast.zip)
    * Exposed ability to have custom buttons via New-BurntToastNotification, passing result from New-BTButton to the -Button parameter.
        * Expect a blog post soon covering some cool ways to use these buttons. Keep an eye out on [king.geek.nz](http://king.geek.nz).
    * Fixed module commands not auto-loading by removing Basic/Advanced function designation ( :( ).
    * Help created for New-BTButton, and the function has had a pass to ensure it works as per the community toolkit.
    * Help completed for New-BurntToastNotification, and Toast alias now exporting correctly.
* [v0.5.1](https://github.com/Windos/BurntToast/releases/download/v0.5.1/BurntToast.zip)
    * Small bug fixes (thanks for opening issues!)
    * Confirmed: Now **ONLY** works on Windows 10
    * BurntToast now has its own, original, logo!
    * New public function to adjust function level of module: Set-BTFunctionLevel
    * Implemented checking for and registering of AppId in the registry to ensure proper Toast behaviour in the Action Center
* [v0.5.0](https://github.com/Windos/BurntToast/releases/download/v0.5.0/BurntToast.zip)
    * Converted to using the UWP Community Toolkit.
    * Snooze and Dismiss now available and working.
    * Documentation is out of date, this will be polished in the next release.
* [v0.4.0](https://github.com/Windos/BurntToast/releases/download/v0.4.0/BurntToast.zip) - Last version that supports Windows 8
    * Credential parameter added so toasts can be generated for regular user when running PowerShell host as a different (e.g. Admin) account.
* [v0.3.0](https://github.com/Windos/BurntToast/releases/download/v0.3.0/BurntToast.zip)
    * Help has been added
    * Toasts can be silent with -Silent switch
    * General bug fixes
* [v0.2.0](https://github.com/Windos/BurntToast/releases/download/v0.2.0/BurntToast.zip)
* [v0.1.0](https://github.com/Windos/BurntToast/releases/download/v0.1.0/BurntToast.zip)

## Contributors
* [Windos](https://github.com/Windos)

## TODO
* see [TODO](TODO.md) file

## License
* see [LICENSE](LICENSE.md) file

## Image Credit
The [default image](BurntToast.png) for BurntToast Notifications is a photo taken by [Craig Sunter](https://www.flickr.com/photos/16210667@N02/17230428864)

## Contact

* Twitter: [@WindosNZ](https://twitter.com/windosnz)
* Blog: [king.geek.nz](http://king.geek.nz/)
