# 该powerShell脚本作用是，将该脚本所在目录下的所有cfg文件的$keysToUpdate项目的值，合并去重之后再重新赋值给各个文件中的对应项目。
# 使用时右键点击 开始菜单，选择 Windows PowerShell (管理员)
# cd 你所有cfg文件所在的文件夹路径
# ./merge_cfg.ps1
# 如果出现权限问题，先运行以下命令来允许脚本执行
# Set-ExecutionPolicy RemoteSigned
# Enter 'Y'

# 脚本效果示例：
# file1.cfg AutoDropList=12345,23456
# file2.cfg AutoDropList=12345,34567
# file3.cfg AutoDropList=12345,45678
# 运行脚本后，file1,2,3.cfg文件都会变成 AutoDropList=12345,23456,34567,45678

# 以下为脚本的处理内容

# 定义要处理的key列表
$keysToMerge = @(
    "AutoDropList",
    "AutoDonationList",
    "AutoSellToVendor",
    "OpenItemList",
    "IgnoreUsingItemList",
    "DecomposeListString",
    "AutoBankInListString"
)

# 存放合并后的值的哈希表
$mergedValues = @{}

# 初始化哈希表
foreach ($key in $keysToMerge) {
    $mergedValues[$key] = @{}
}

# 获取当前文件夹下的所有 .cfg 文件
$configFiles = Get-ChildItem -Path . -Filter *.cfg | ForEach-Object { $_.FullName }

# 定义 GB2312 编码
$gb2312 = [System.Text.Encoding]::GetEncoding("GB2312")

# 读取文件并合并值
foreach ($file in $configFiles) {
    $contentBytes = [System.IO.File]::ReadAllBytes($file)
    $content = $gb2312.GetString($contentBytes)
    
    foreach ($line in $content -split "`r`n") {
        foreach ($key in $keysToMerge) {
            if ($line -match "^$key=(.*)") {
                $values = $matches[1] -split ','
                foreach ($value in $values) {
                    $mergedValues[$key][$value] = $true
                }
            }
        }
    }
}

# 更新文件内容
foreach ($file in $configFiles) {
    $contentBytes = [System.IO.File]::ReadAllBytes($file)
    $content = $gb2312.GetString($contentBytes) -split "`r`n"
    
    for ($i = 0; $i -lt $content.Length; $i++) {
        foreach ($key in $keysToMerge) {
            if ($content[$i] -match "^$key=") {
                $newValues = $mergedValues[$key].Keys -join ','
                $content[$i] = "$key=$newValues"
            }
        }
    }
    
    $newContent = $content -join "`r`n"
    $newContentBytes = $gb2312.GetBytes($newContent)
    [System.IO.File]::WriteAllBytes($file, $newContentBytes)
}
