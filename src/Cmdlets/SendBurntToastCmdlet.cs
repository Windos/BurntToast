using BurntToast.Internal;
using Microsoft.Windows.AppNotifications;
using Microsoft.Windows.AppNotifications.Builder;
using System.Management.Automation;

namespace BurntToast.Cmdlets
{
    [Cmdlet(VerbsCommunications.Send, "BurntToast")]
    public class SendBurntToastCommand : Cmdlet
    {
        [Parameter(Position = 0)]
        public string[]? Text { get; set; }

        protected override void ProcessRecord()
        {
            WriteVerbose("Building toast notification...");

            Config config = ConfigManager.LoadConfig();
            string appLogoPath = config.AppLogoPath;
            string fullAppLogoPath = Path.GetFullPath(appLogoPath);
            Console.WriteLine($"[BurntToast] DEBUG: Registering with AppLogo: {fullAppLogoPath}");

            if (!File.Exists(fullAppLogoPath))
            {
                throw new FileNotFoundException($"AppLogo file not found at path: {fullAppLogoPath}");
            }

            var appLogoUri = new Uri(fullAppLogoPath);

            try
            {
                var builder = new AppNotificationBuilder();

                if (Text == null ||
                    Text.Length == 0 ||
                    (Text.Length == 1 && string.IsNullOrEmpty(Text[0])))
                {
                    builder.AddText("Default Notification");
                }
                else
                {
                    foreach (var line in Text)
                    {
                        builder.AddText(line);
                    }
                }

                builder.SetAppLogoOverride(appLogoUri);

                var appNotification = builder.BuildNotification();

                AppNotificationManager.Default.Show(appNotification);

                WriteVerbose("Toast notification sent.");
            }
            catch (Exception ex)
            {
                if (ex.ToString().Contains("Maximum number of text elements added"))
                {
                    var specificException = new System.InvalidOperationException(
                        "Too many lines of text. Reduce the number of strings passed to the Text parameter.",
                        ex
                    );

                    var clearErrorRecord = new ErrorRecord(
                        specificException,
                        "TooManyTextElements",
                        ErrorCategory.LimitsExceeded,
                        this
                    );
                    WriteError(clearErrorRecord);
                }
                else
                {
                    var errorRecord = new ErrorRecord(
                        ex,
                        "ToastSendFailed",
                        ErrorCategory.WriteError,
                        this
                    );
                    WriteError(errorRecord);
                }
            }
        }
    }
}