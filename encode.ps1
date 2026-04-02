$path = "c:\Users\brahi\OneDrive - KFUPM\Research_KFUPM\websites\BrahimB88.github.io\index.html"
$html = Get-Content $path -Raw
$html = $html -replace 'https://BrahimB88\.github\.io/#news-', 'https://BrahimB88.github.io/%23news-'
Set-Content $path -Value $html -NoNewline
