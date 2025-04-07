# UTF-8 code page for emoji compatibility
chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# $OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Write-Host "Emoji test: 🧪 🔥 🎶 ♪ 🎸 🎯 🎉 📦 ✨ ✅ ♻️"