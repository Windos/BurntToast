using System.Management.Automation;
using BurntToast.Internal;

namespace BurntToast.Cmdlets
{
    [Cmdlet(VerbsCommon.Reset, "BurntToastConfig")]
    public class ResetBurntToastConfigCommand : Cmdlet
    {
        [Parameter()]
        public SwitchParameter PassThru { get; set; }

        protected override void ProcessRecord()
        {
            try
            {
                string configPath = ConfigManager.GetConfigFilePath();

                if (File.Exists(configPath))
                {
                    File.Delete(configPath);
                    WriteVerbose("Configuration file deleted. Defaults will be used on next session.");
                }
                else
                {
                    WriteVerbose("Configuration file not found. Defaults are already in use.");
                }

                if (this.PassThru)
                {
                    WriteObject(ConfigManager.LoadConfig());
                }

                WriteWarning("Please restart your PowerShell session for this change to take effect.");
            }
            catch (Exception ex)
            {
                WriteError(new ErrorRecord(ex, "ConfigResetFailed", ErrorCategory.WriteError, this));
            }
        }
    }
}