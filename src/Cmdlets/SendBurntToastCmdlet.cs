using BurntToast.Internal;
using Microsoft.Windows.AppNotifications;
using Microsoft.Windows.AppNotifications.Builder;
using System.Management.Automation;

namespace BurntToast.Cmdlets
{
    [Cmdlet(
        VerbsCommunications.Send, "BurntToast",
        DefaultParameterSetName = "Sound"
    )]
    public class SendBurntToastCommand : Cmdlet
    {
        [Parameter(
            Position = 0,
            HelpMessage = "Up to 3 strings to show within the Toast Notification. The first is the title."
        )]
        [ValidateCount(0,3)]
        public string[]? Text { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "Path to an image that will appear as the application logo."
        )]
        [ValidateNotNullOrEmpty]
        public string? AppLogo { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "The crop applied to the application logo, either Circle or Square. Defaults to Circle."
        )]
        [ValidateSet("Circle", "Square")]
        public string? AppLogoCrop { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "Path to a prominent hero image for the notification."
        )]
        [ValidateNotNullOrEmpty]
        public string? HeroImage { get; set; }

        [Parameter(
            Mandatory = false,
            HelpMessage = "Optional attribution text displayed at the bottom of the notification. Only supported on modern versions of Windows."
        )]
        [ValidateNotNullOrEmpty]
        public string? Attribution { get; set; }

        [Parameter(
            Mandatory = false,
            ParameterSetName = "Sound",
            HelpMessage = "The sound to play when displaying the toast notification. Choose from Default, alarms, calls, etc. (Cannot be used with Silent.)"
        )]
        public AppNotificationSoundEvent Sound { get; set; } = AppNotificationSoundEvent.Default;

        [Parameter(
            Mandatory = true,
            ParameterSetName = "Silent",
            HelpMessage = "Mute any audio associated with the toast notification."
        )]
        public SwitchParameter Silent { get; set; }

        protected override void ProcessRecord()
        {
            WriteVerbose("Building toast notification...");

            Config config = ConfigManager.LoadConfig();
            string appLogoPath = config.AppLogoPath;
            string fullAppLogoPath = Path.GetFullPath(appLogoPath);

            if (AppLogo != null)
            {
                fullAppLogoPath = Path.GetFullPath(AppLogo);
            }

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

                var appLogoCrop = AppNotificationImageCrop.Default;

                if (AppLogoCrop != null)
                {
                    if (AppLogoCrop == "Circle")
                    {
                        appLogoCrop = AppNotificationImageCrop.Circle;
                    }
                }
                else if (config.AppLogoCrop == "Circle")
                {
                    appLogoCrop = AppNotificationImageCrop.Circle;
                }

                builder.SetAppLogoOverride(appLogoUri, appLogoCrop);

                if (HeroImage != null)
                {
                    string fullHeroImagePath = Path.GetFullPath(HeroImage);

                    if (!File.Exists(fullHeroImagePath))
                    {
                        throw new FileNotFoundException($"Hero Image file not found at path: {fullHeroImagePath}");
                    }

                    var heroImageUri = new Uri(fullHeroImagePath);
                    builder.SetHeroImage(heroImageUri);
                }

                if (Attribution != null)
                {
                    builder.SetAttributionText(Attribution);
                }

                if (Silent.IsPresent)
                {
                    builder.MuteAudio();
                }
                else
                {
                    builder.SetAudioEvent(Sound);
                }

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