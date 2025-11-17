using System.Reflection;
using System.Text.Json.Serialization;

namespace BurntToast.Internal
{
    public class Config
    {
        public string AppName { get; set; } = "BurntToast";
        public string IconPath { get; set; } = string.Empty;

        public string AppLogoPath { get; set; } = string.Empty;
    }

    public static class ConfigManager
    {
        private static string _defaultIconPath = string.Empty;
        private static string _defaultAppLogoPath = string.Empty;

        private static string GetModuleAssetsPath()
        {
            string? assemblyLocation = Assembly.GetExecutingAssembly().Location;
            string? modulePath = Path.GetDirectoryName(assemblyLocation);

            if (string.IsNullOrEmpty(modulePath))
            {
                return string.Empty;
            }

            return Path.Combine(modulePath, "Assets");
        }

        public static string DefaultIconPath
        {
            get
            {
                return Path.Combine(GetModuleAssetsPath(), "BurntToast-Logo.png");
            }
        }

        public static string DefaultAppLogoPath
        {
            get
            {
                return Path.Combine(GetModuleAssetsPath(), "BurntToast.png");
            }
        }

        private static readonly string _configFolderPath = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
            "BurntToast"
        );

        private static readonly string _configFilePath = Path.Combine(
            _configFolderPath,
            "config.json"
        );

        public static string GetConfigFilePath()
        {
            return _configFilePath;
        }

        public static Config LoadConfig()
        {
            if (!File.Exists(_configFilePath))
            {
                var defaultConfig = new Config();
                defaultConfig.IconPath = DefaultIconPath;
                defaultConfig.AppLogoPath = DefaultAppLogoPath;
                return defaultConfig;
            }

            try
            {
                string json = File.ReadAllText(_configFilePath);
                var config = System.Text.Json.JsonSerializer.Deserialize<Config>(json);

                if (config == null) { return LoadConfig(); }

                return config;
            }
            catch (Exception)
            {
                var defaultConfig = new Config();
                defaultConfig.IconPath = DefaultIconPath;
                defaultConfig.AppLogoPath = DefaultAppLogoPath;
                return defaultConfig;
            }
        }

        public static void SaveConfig(Config config)
        {
            Directory.CreateDirectory(_configFolderPath);
            string json = System.Text.Json.JsonSerializer.Serialize(config);
            File.WriteAllText(_configFilePath, json);
        }
    }
}