# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Pin the main Monaco Editor ES module
pin "monaco-editor", to: "https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/+esm", preload: true

# Pin worker scripts for basic functionality (no specific LaTeX worker exists by default)
pin "monaco-editor/editor.worker", to: "https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/esm/vs/editor/editor.worker.js", preload: true
pin "monaco-editor/json.worker", to: "https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/esm/vs/language/json/json.worker.js", preload: true
pin "monaco-editor/ts.worker", to: "https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/esm/vs/language/typescript/ts.worker.js", preload: true
