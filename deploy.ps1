
# 前回の分を削除
Remove-Item -Path "./docs*.*" -Force -Recurse

# 資産系をコピー
Copy-Item -Path "./public/index.html" -Destination "./docs/index.html" -Recurse
Copy-Item -Path "./public/style.scss" -Destination "./docs/style.scss" -Recurse
Copy-Item -Path "./public/style.css" -Destination "./docs/style.css" -Recurse
Copy-Item -Path "./public/favicon.ico" -Destination "./docs/favicon.ico" -Recurse

# elmファイルのビルドとデプロイ
elm make "src/Main.elm" --optimize --output="docs/elm.js"
