using System.Management.Automation;
using BurntToast.Internal;

namespace BurntToast.Cmdlets
{
    [Cmdlet(VerbsCommon.Set, "BurntToastConfig")]
    public class SetBurntToastConfigCommand : Cmdlet
    {
        [Parameter(Mandatory = true, Position = 0)]
        public string AppName { get; set; } = "BurntToast";

        [Parameter(Mandatory = true, Position = 1)]
        public string IconPath { get; set; } = string.Empty;

        [Parameter(Mandatory = true, Position = 2)]
        public string AppLogoPath { get; set; } = string.Empty;

        [Parameter(Mandatory = false, Position = 3)]
        [ValidateSet("Circle", "Square")]
        public string AppLogoCrop { get; set; } = "Circle";

        protected override void ProcessRecord()
        {
            try
            {
                string fullIconPath = Path.GetFullPath(this.IconPath);
                string fullAppLogoPath = Path.GetFullPath(this.AppLogoPath);

                if (!File.Exists(fullIconPath))
                {
                    var fileNotFoundError = new ErrorRecord(
                        new FileNotFoundException($"Icon file not found at path: {fullIconPath}"),
                        "FileNotFound",
                        ErrorCategory.ObjectNotFound,
                        this.IconPath
                    );
                    WriteError(fileNotFoundError);
                    return;
                }

                if (!File.Exists(fullAppLogoPath))
                {
                    var fileNotFoundError = new ErrorRecord(
                        new FileNotFoundException($"AppLogo file not found at path: {fullAppLogoPath}"),
                        "FileNotFound",
                        ErrorCategory.ObjectNotFound,
                        this.AppLogoPath
                    );
                    WriteError(fileNotFoundError);
                    return;
                }

                var config = new Config
                {
                    AppName = this.AppName,
                    IconPath = fullIconPath,
                    AppLogoPath = fullAppLogoPath,
                    AppLogoCrop = this.AppLogoCrop
                };

                ConfigManager.SaveConfig(config);

                WriteWarning("Configuration Set. Please restart your PowerShell session for these changes to take effect.");
            }
            catch (Exception ex)
            {
                WriteError(new ErrorRecord(ex, "ConfigSaveFailed", ErrorCategory.WriteError, this));
            }
        }
    }
}