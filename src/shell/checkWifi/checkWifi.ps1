# 设置日志文件路径
$logFilePath = "C:\Path\To\Your\LogFile.txt"

# 定义检查Wi-Fi连接的函数
function Check-WiFiConnection {
    # 获取Wi-Fi连接状态
    $wifiStatus = (Get-NetAdapter -Name "Wi-Fi").status
    
    # 检查是否断线
    if ($wifiStatus -ne 'Up') {
        # 获取当前时间
        $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        
        # 记录日志
        $logEntry = "$currentTime - Wi-Fi connection lost."
        Add-Content -Path $logFilePath -Value $logEntry
        
        # 重启系统
        Restart-Computer -Force
    }
}

# 循环检查每隔15分钟
while ($true) {
    Check-WiFiConnection
    Start-Sleep -Seconds 900  # 等待15分钟（900秒）
}
