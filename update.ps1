$path = "c:\Users\brahi\OneDrive - KFUPM\Research_KFUPM\websites\BrahimB88.github.io\index.html"
$html = Get-Content $path -Raw

# Add id to news-items
$html = $html -replace '<!-- News Item: QArm Training \(April 2026\) -->\r?\n\s*<div class="news-item">', "<!-- News Item: QArm Training (April 2026) -->`n                <div class=`"news-item`" id=`"news-qarm`">"
$html = $html -replace '<!-- News Item: MDPI Paper \(Feb 2026\) -->\r?\n\s*<div class="news-item">', "<!-- News Item: MDPI Paper (Feb 2026) -->`n                <div class=`"news-item`" id=`"news-mdpi`">"
$html = $html -replace '<!-- News Item: Conference Paper Online \(Feb 2026\) -->\r?\n\s*<div class="news-item">', "<!-- News Item: Conference Paper Online (Feb 2026) -->`n                <div class=`"news-item`" id=`"news-emg`">"
$html = $html -replace '<!-- News Item 1 \(New\) -->\r?\n\s*<div class="news-item">', "<!-- News Item 1 (New) -->`n                <div class=`"news-item`" id=`"news-access`">"
$html = $html -replace '<div class="news-item">\r?\n\s*<img src="assets/news/ali_mustafa_defense.png"', "<div class=`"news-item`" id=`"news-ali`">`n                    <img src=`"assets/news/ali_mustafa_defense.png`""
$html = $html -replace '<div class="news-item">\r?\n\s*<img src="assets/news/ahmed_taibeche_defense.png"', "<div class=`"news-item`" id=`"news-ahmed`">`n                    <img src=`"assets/news/ahmed_taibeche_defense.png`""

# We need to replace the hrefs inside the share bar for each ID.
# Since we know the order of occurrences matches the order of IDs:
$ids = "news-qarm","news-mdpi","news-emg","news-access","news-ali","news-ahmed"
$blocks = $html -split "<span style=`"color: var\(--text-secondary\); font-size: 0\.9rem;`">Share:</span>"
$newHtml = $blocks[0]
for ($i=1; $i -lt $blocks.Count; $i++) {
    if ($i -le $ids.Length) {
        $id = $ids[$i-1]
        
        # In the block, replace the next 3 occurrences of https://BrahimB88.github.io
        $rest = $blocks[$i]
        $rest = $rest -replace 'https://BrahimB88\.github\.io" target="_blank"\r?\n\s*title="Share on X"', "https://BrahimB88.github.io/#$id`" target=`"_blank`"`n                                title=`"Share on X`""
        $rest = $rest -replace 'https://BrahimB88\.github\.io"\r?\n\s*target="_blank" title="Share on Facebook"', "https://BrahimB88.github.io/#$id`"`n                                target=`"_blank`" title=`"Share on Facebook`""
        $rest = $rest -replace 'https://BrahimB88\.github\.io"\r?\n\s*target="_blank" title="Share on LinkedIn"', "https://BrahimB88.github.io/#$id`"`n                                target=`"_blank`" title=`"Share on LinkedIn`""
        
        $newHtml += ("<span style=`"color: var(--text-secondary); font-size: 0.9rem;`">Share:</span>" + $rest)
    } else {
        $newHtml += ("<span style=`"color: var(--text-secondary); font-size: 0.9rem;`">Share:</span>" + $blocks[$i])
    }
}

Set-Content $path -Value $newHtml -NoNewline
