@echo off
chcp 65001 >nul
powershell -Command "$mapping = @{}; $alphaFolders = Get-ChildItem -Directory | Where-Object { $_.Name -match '^[A-M|a-m]$|^[N-Z|n-z]$|^Others$' }; foreach ($alpha in $alphaFolders) { Get-ChildItem -Path $alpha.FullName -Directory | ForEach-Object { $mapping[$_.Name] = $_.FullName } }; $newItems = Get-ChildItem -Path '1'; foreach ($item in $newItems) { $clean = $item.BaseName -replace '^[\s\(\[（【#]*([Nn][Oo]\.?\s*\d+|#\d+|\d+)[\s\-_.]*', '' -replace '^[\s\(\[（【#]+', ''; $targetName = ($clean -split '[ \-_\(\)\[\]（））【】]|NO\.?')[0].Trim(); if ($mapping.ContainsKey($targetName)) { $dest = $mapping[$targetName]; Move-Item -LiteralPath $item.FullName -Destination $dest -Force; Write-Host '成功归类：' $item.Name ' -> ' $dest -ForegroundColor Green } else { Write-Host '未匹配到已有目录：' $item.Name -ForegroundColor Gray } }"
echo.
echo 任务完成！无法匹配的文件（即从未出现过的名字）仍留在“1”文件夹中。
pause
