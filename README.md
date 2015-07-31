# BurntToast
PowerShell Module for displaying Windows 8/10 Toast Notifications

## Install

### Manual Install

Download [BurntToast.zip](https://github.com/Windos/BurntToast/releases/download/Latest/BurntToast.zip) and extract the contents into `C:\Users\[User]\Documents\WindowsPowerShell\modules\BurntToast` (you may have to create these directories if they don't exist.)

### Scripted Install

Open a PowerShell console or the PowerShell ISE and run the following:

    iex ((New-Object net.webclient).DownloadString('https://raw.githubusercontent.com/Windos/BurntToast/master/install.ps1'))

_Note that your Execution Policy should be set to at least Bypass. See [about_Execution_Policies](https://technet.microsoft.com/en-us/library/hh847748.aspx) for more details._

### PowerShell Gallery Install (Requires PowerShell v5)

_See the [PowerShell Gallery](http://www.powershellgallery.com/packages/BurntToast/) for the complete details and instructions._

## Example

    New-BurntToastNotification -FirstLine 'Random Background Job' -SecondLine 'You background job has finished. This text is really long and wraps to the third line.'
	
### Windows 8.1

![BurntToast Notification Example in Windows 8.1](/Images/Toast-Win8.png)

### Windows 10

![BurntToast Notification Example in Windows 10](/Images/Toast-Win10.png)

## Releases
* [Bleeding Edge](https://github.com/Windos/BurntToast/archive/master.zip) (Development/Raw Repo - **CAUTION**)
* [Latest Release](https://github.com/Windos/BurntToast/releases/download/Latest/BurntToast.zip)
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
* Livecoding.tv: [Windos](https://www.livecoding.tv/windos/)
