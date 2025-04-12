Add-Type -AssemblyName Microsoft.VisualBasic

# 设置根目录
$basePath = "C:\Users\r\Desktop"

# 找出所有名为 node_modules 的目录
$folders = Get-ChildItem -Path $basePath -Recurse -Directory -Force | Where-Object { $_.Name -eq "node_modules" }

# 按路径长度倒序排序（深的先删）
$sortedFolders = $folders | Sort-Object { $_.FullName.Length } -Descending

foreach ($folder in $sortedFolders) {
    Write-Host "Sending $($folder.FullName) to Recycle Bin..."
    try {
        if (Test-Path $folder.FullName) {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory(
                $folder.FullName,
                [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs,
                [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin
            )
        } else {
            Write-Warning "$($folder.FullName) no longer exists. Skipping."
        }
    } catch {
        Write-Warning "Failed to delete: $($folder.FullName). Reason: $_"
    }
}
