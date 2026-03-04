@echo off
chcp 65001 >nul
powershell -Command "$files = Get-ChildItem | Where-Object { $_.Name -ne '分类.bat' }; foreach ($f in $files) { $b = $f.BaseName -replace '^[\s\(\[（【#]*([Nn][Oo]\.?\s*\d+|#\d+|\d+)[\s\-_.]*', '' -replace '^[\s\(\[（【#]+', ''; $name = ($b -split '[ \-_\(\)\[\]（））【】]|NO\.?')[0].Trim(); if ($name -ne '' -and $name -ne $f.Name) { if (!(Test-Path -LiteralPath $name)) { New-Item -ItemType Directory -Name $name }; Move-Item -LiteralPath $f.FullName -Destination $name -Force } }"
echo ✨ 任务完成！#号、no.、数字前缀已全部强制过滤。
pause
