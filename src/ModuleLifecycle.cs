using Microsoft.Windows.AppNotifications;
using System.Management.Automation;
using Microsoft.Windows.ApplicationModel.DynamicDependency;
using BurntToast.Internal;

namespace BurntToast
{
    public class ModuleLifecycle : IModuleAssemblyInitializer, IModuleAssemblyCleanup
    {
        public void OnImport()
        {
            try
            {
                // --- 1. BOOTSTRAPPER ---
                bool success = Bootstrap.TryInitialize(0x00010008, out int hresult);
                if (!success)
                {
                    throw new InvalidOperationException($"Failed to initialize Windows App SDK Bootstrapper. HRESULT: 0x{hresult:X}");
                }

                // --- 2. LOAD CONFIGURATION ---
                Config config = ConfigManager.LoadConfig();
                string appName = config.AppName;
                string iconPath = config.IconPath;
                string appLogoPath = config.AppLogoPath;

                // --- 3. NORMALIZE PATH AND CREATE URI ---
                string fullIconPath = Path.GetFullPath(iconPath);

                Console.WriteLine($"[BurntToast] DEBUG: Registering with AppName: {appName}");
                Console.WriteLine($"[BurntToast] DEBUG: Registering with Icon: {fullIconPath}");

                if (!File.Exists(fullIconPath))
                {
                    throw new FileNotFoundException($"Icon file not found at path: {fullIconPath}");
                }

                var iconUri = new Uri(fullIconPath);

                // 4. REGISTER ---
                AppNotificationManager.Default.Register(appName, iconUri);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[BurntToast] FATAL ERROR during import: {ex.Message}");
            }
        }

        public void OnRemove(PSModuleInfo module)
        {
            AppNotificationManager.Default.Unregister();
            Bootstrap.Shutdown();
        }
    }
}