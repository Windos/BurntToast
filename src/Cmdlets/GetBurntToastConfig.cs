using System.Management.Automation;
using BurntToast.Internal;

namespace BurntToast.Cmdlets
{
    [Cmdlet(VerbsCommon.Get, "BurntToastConfig")]
    public class GetBurntToastConfigCommand : Cmdlet
    {
        protected override void ProcessRecord()
        {
            try
            {
                Config config = ConfigManager.LoadConfig();
                WriteObject(config);
            }
            catch (Exception ex)
            {
                WriteError(new ErrorRecord(ex, "ConfigReadFailed", ErrorCategory.ReadError, this));
            }
        }
    }
}