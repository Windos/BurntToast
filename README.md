# Chinese-BurntToast 气泡通知

个人将需要的部分通过ai进行一部分汉化供个人使用，原仓库链接[点此查看](http://github.com/Windos/BurntToast)

## Install 下载

### PowerShell库安装（需要 PowerShell v5）

```powershell
Install-Module -Name BurntToast
```
有关完整详细信息和说明，请参阅 [PowerShell 库](http://www.powershellgallery.com/packages/BurntToast/) 。不要忘记设置正确的 [执行策略](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.1)。

### 手动下载

从[版本界面](https://github.com/Windos/BurntToast/releases/latest)下载[BurntToast.zip](https://github.com/Windos/BurntToast/releases/latest/download/BurntToast.zip)，并将其内容解压到$env:userprofile\Documents\WindowsPowerShell\modules\BurntToast（如果这些目录不存在，你可能需要手动创建它们）。

如果你使用的是 PowerShell 6 或更高版本，请解压到$env:userprofile\Documents\PowerShell\Modules\BurntToast。请记得在解压内容之前将zip文件**解除锁定**。否则zip无法正常解压。
这可以通过下列两种方法完成
- 文件属性
  1. 右键单击下载的 zip 文件，选择“属性”。
  2. 在弹出的属性窗口中，查看“安全”或“常规”选项界面下是否有“解除锁定”按钮。
  3. 如果存在该按钮，点击它即可解除zip的锁定状态。
或使用
- Unblock-File命令。
  ```powershell
  Get-Item "C:\path\to\your\BurntToast.zip" | Unblock-File
  ```

## 案例

### [默认气泡](/Examples/Example01/)

```powershell
New-BurntToastNotification
```

![BurntToast Notification Example Default](/Examples/Example01/Example1-Default.png)

### [自定义气泡](/Examples/Example02/)

```powershell
New-BurntToastNotification -AppLogo C:\smile.jpg -Text "Don't forget to smile!",
                                                       'Your script ran successfully, celebrate!'
```

![BurntToast Notification Example Custom](/Examples/Example02/Example2-Custom.png)

### [闹钟](/Examples/Example03/)

```powershell
New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2' -SnoozeAndDismiss
```

![BurntToast Notification Example Alarm](/Examples/Example03/Example3-Alarm.png)

## 发布版本

**请注意** ：从 v0.5.0 开始，BurntToast 不再支持 Windows 8。

  - [0.8.5](https://github.com/Windos/BurntToast/releases/download/v0.8.5/BurntToast.zip)
  
    - 实现了使用 UniqueIdentifier 与 Remove-BTNotification 函数的功能（在 0.8.4 中部分实现）
    
  - [0.8.4](https://github.com/Windos/BurntToast/releases/download/v0.8.4/BurntToast.zip)
  
    - 修改：New-BTHeader 的 Header ID 现在是可选的。如果未指定，将自动生成 ID([#125](https://github.com/Windos/BurntToast/issues/125))
    
      - 感谢 [@glennsarti](https://github.com/glennsarti)
    
    - 增强：现在可以通过 New-BurntToastNotification 函数使用 -HeroImage 参数指定英雄图片([#80](https://github.com/Windos/BurntToast/issues/80))
    
      - 感谢 [@UniverseCitiz3n](https://github.com/UniverseCitiz3n)
    
    - 增强：现在可以通过 New-BurntToastNotification 函数使用 -AppId 参数指定 AppIDs
    
      - 感谢 [@cedarbaum](https://github.com/cedarbaum)
    
    - 增强：现在可以在使用 Remove-BTNotification 函数时指定 UniqueIdentifier，而不仅仅是组件标签和组字符串
    
    - 修复：从 Twitch/IRC 获取文本并将其用于 toast 时出现的一些奇怪边缘情况现已解决
    
      - 感谢 [@potatoqualitee](https://github.com/potatoqualitee) 和 [@vexx32](https://github.com/vexx32)
    
  - [0.8.3](https://github.com/Windos/BurntToast/releases/download/v0.8.3/BurntToast.zip)
  
    - 修复：在 PowerShell 6.0+ 上运行 Update-BTNotification 时出现的错误([#120](https://github.com/Windos/BurntToast/issues/120))
    
    - 修复：在任何版本上使用可操作的 toast 参数时出现的错误（[#122](https://github.com/Windos/BurntToast/issues/122)）
    
    - 修复：指定多种事件类型时出现的多个关于事件不支持的警告
    
  - [v0.8.2](https://github.com/Windos/BurntToast/releases/download/v0.8.2/BurntToast.zip)
  
    - 增加：现在可以通过 New-BTColumn 使用 AdaptiveGroups
    
  - [v0.8.1](https://github.com/Windos/BurntToast/releases/download/v0.8.1/BurntToast.zip)
  
    - 修复：在 0.8.0 中移除的 Toast 别名已恢复
    
    - 弃用：在未来版本 v0.9.0 中将移除 Shoulder Tap cmdlets
    
    - 弃用：在未来版本 v0.9.0 中将移除 New-BTAudio 的 Path 参数
    
      - 参见 [MicrosoftDocs/windows-uwp Issue #1593](https://github.com/MicrosoftDocs/windows-uwp/issues/1593)
    
  - [v0.8.0](https://github.com/Windos/BurntToast/releases/download/v0.8.0/BurntToast.zip)
  
    - 修复：UNC 路径的图片无法加载的问题（#111）
    
    - 增加：可以通过 New-BTImage 的 IgnoreCache 开关强制刷新缓存图片
    
    - 增加：ACTIONABLE NOTIFICATIONS！通过 Submit-BTNotification 和 New-BurntToastNotification 的 ActivatedAction 和 DismissedAction 参数公开
    
  - [v0.7.2](https://github.com/Windos/BurntToast/releases/download/v0.7.2/BurntToast.zip)
  
    - 修复：“提醒”弹出时出现的大括号问题([#72](https://github.com/Windos/BurntToast/issues/72))
    
    - 修复：缓存的远程 gif 根据其远程文件名保存，不会被覆盖([#105](https://github.com/Windos/BurntToast/issues/105))
    
      - 感谢 [@KelvinTegelaar](https://github.com/KelvinTegelaar)
    
    - 修复：BurntToast 和 .NET 5 的兼容性问题([#101](https://github.com/Windos/BurntToast/issues/101))
  
  - 更多内容请查看[完整变更日志](CHANGES.md)

## 贡献者

- [Windos](https://github.com/Windos)
- [jeremytbrun](https://github.com/jeremytbrun)
- [KelvinTegelaar](https://github.com/KelvinTegelaar)
- [steviecoaster](https://github.com/steviecoaster)
- [glennsarti](https://github.com/glennsarti)
- [UniverseCitiz3n](https://github.com/UniverseCitiz3n)
- [cedarbaum](https://github.com/cedarbaum)

## 许可证

- 请查看 [LICENSE](LICENSE) 文件

## 图片版权

BurntToast通知的[默认图片](/Media/BurntToast.png)是由[Craig Sunter](https://www.flickr.com/photos/16210667@N02/17230428864)拍摄的照片

## 联系地址

- Twitter: [@WindosNZ](https://twitter.com/windosnz)
- Blog: [ToastIT.dev](https://toastit.dev/)
