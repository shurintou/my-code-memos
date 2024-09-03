# 该powerShell脚本作用是，将该脚本所在目录下的所有cfg文件的$keysToUpdate项目的值，更改为指定cfg文件$referenceFile中对应项目的值。
# 使用时右键点击 开始菜单，选择 Windows PowerShell (管理员)
# cd 你所有cfg文件所在的文件夹路径
# ./specificated_merge_cfg.ps1
# 如果出现权限问题，先运行以下命令来允许脚本执行
# Set-ExecutionPolicy RemoteSigned
# Enter 'Y'

# 脚本效果示例：
# 假设指定$referenceFile为file1.cfg
# file1.cfg AutoDropList=12345,23456
# file2.cfg AutoDropList=12345,34567
# file3.cfg AutoDropList=45678
# 运行脚本后，file1,2,3.cfg文件都会变成 AutoDropList=12345,23456

# 以下为脚本的处理内容

# 指定包含更新值的 .cfg 文件
$referenceFile = "path\your_filename.CFG"  # 请替换为实际文件的绝对路径

# 定义要处理的 key 列表
$keysToUpdate = @(
    "AutoDropList",
    "AutoDonationList",
    "AutoSellToVendor",
    "OpenItemList",
    "IgnoreUsingItemList",
    "DecomposeListString",
    "AutoBankInListString"
)

# 定义 GB2312 编码
$gb2312 = [System.Text.Encoding]::GetEncoding("GB2312")

# 读取指定文件中的 key 值
$referenceContentBytes = [System.IO.File]::ReadAllBytes($referenceFile)
$referenceContent = $gb2312.GetString($referenceContentBytes) -split "`r`n"

# 存放从指定文件读取的值
$referenceValues = @{}

foreach ($line in $referenceContent) {
    foreach ($key in $keysToUpdate) {
        if ($line -match "^$key=(.*)") {
            $referenceValues[$key] = $matches[1]
        }
    }
}

# 获取当前文件夹下的所有 .cfg 文件
$configFiles = Get-ChildItem -Path . -Filter *.cfg | ForEach-Object { $_.FullName }

# 更新所有文件中的 key 值
foreach ($file in $configFiles) {
    $contentBytes = [System.IO.File]::ReadAllBytes($file)
    $content = $gb2312.GetString($contentBytes) -split "`r`n"
    
    for ($i = 0; $i -lt $content.Length; $i++) {
        foreach ($key in $keysToUpdate) {
            if ($content[$i] -match "^$key=") {
                if ($referenceValues.ContainsKey($key)) {
                    $content[$i] = "$key=$($referenceValues[$key])"
                }
            }
        }
    }
    
    $newContent = $content -join "`r`n"
    $newContentBytes = $gb2312.GetBytes($newContent)
    [System.IO.File]::WriteAllBytes($file, $newContentBytes)
}

