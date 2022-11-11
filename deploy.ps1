
Copy-Item -Path "./src/index.html" -Destination "./docs/index.html" -Recurse
Copy-Item -Path "./src/style.scss" -Destination "./docs/style.scss" -Recurse
Copy-Item -Path "./src/style.css" -Destination "./docs/style.css" -Recurse
elm make "src/Main.elm" --optimize --output="docs/elm.js"
