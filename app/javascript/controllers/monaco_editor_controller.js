import { Controller } from "@hotwired/stimulus"

import * as monaco from "monaco-editor";

// Register LaTeX language
monaco.languages.register({ id: 'tex' });

// Configure language features
monaco.languages.setLanguageConfiguration('tex', {
  brackets: [
    ['{', '}'],
    ['[', ']'],
    ['(', ')']
  ],
  autoClosingPairs: [
    { open: '{', close: '}' },
    { open: '[', close: ']' },
    { open: '(', close: ')' },
    { open: '\\begin{', close: '\\end{}' }
  ],
  surroundingPairs: [
    { open: '{', close: '}' },
    { open: '[', close: ']' },
    { open: '(', close: ')' }
  ]
});

// Define LaTeX tokenizer with improved syntax highlighting
monaco.languages.setMonarchTokensProvider('tex', {
  defaultToken: 'invalid',
  tokenPostfix: '.tex',

  keywords: [
    'documentclass', 'usepackage', 'begin', 'end', 'section', 'subsection',
    'subsubsection', 'textbf', 'textit', 'emph', 'caption', 'label', 'ref'
  ],

  tokenizer: {
    root: [
      // Comments (green)
      [/%.*/, 'comment'],

      // LaTeX commands (blue)
      [/\\[a-zA-Z]+/, {
        cases: {
          '@keywords': 'keyword',
          '@default': 'keyword'
        }
      }],

      // Specific delimiter rules (yellow)
      [/\{/, { token: 'delimiter.curly', bracket: '@open' }],
      [/\}/, { token: 'delimiter.curly', bracket: '@close' }],
      [/\[/, { token: 'delimiter.square', bracket: '@open' }],
      [/\]/, { token: 'delimiter.square', bracket: '@close' }],
      [/\(/, { token: 'delimiter.round', bracket: '@open' }],
      [/\)/, { token: 'delimiter.round', bracket: '@close' }],

      // Math mode (special handling)
      [/\$/, { token: 'math', bracket: '@open', next: '@math' }],

      // Text content: updated to exclude delimiters so they aren’t swallowed
      [/[^\\%$\{\}\[\]\(\)]+/, 'string'],
    ],

    math: [
      [/\$/, { token: 'math', bracket: '@close', next: '@pop' }],
      [/\\\w+/, 'keyword.math'],
      [/[^$]+/, 'string.math']
    ],
  }
});

// Define themes with custom delimiter tokens
// Light theme
monaco.editor.defineTheme('latex-light', {
  base: 'vs', // Based on light theme
  inherit: true,
  rules: [
    { token: 'comment', foreground: '6A9955' },
    { token: 'keyword', foreground: '569CD6' },
    { token: 'string', foreground: '616161' },
    { token: 'delimiter.curly', foreground: 'FFD700' },
    { token: 'delimiter.square', foreground: 'FFD700' },
    { token: 'delimiter.round', foreground: 'FFD700' },
    { token: 'math', foreground: 'CE9178' }
  ],
  colors: {
    'editor.background': '#FFFFFF',
    'editor.foreground': '#000000',
    'editor.lineHighlightBackground': '#F5F5F5',
    'editorCursor.foreground': '#000000',
    'editor.lineNumbers': '#2A2A2A',
    'editor.selectionBackground': '#ADD6FF',
    'editor.inactiveSelectionBackground': '#E5E5E5',
  }
});

// Dark theme
monaco.editor.defineTheme('latex-dark', {
  base: 'vs-dark', // Based on dark theme
  inherit: true,
  rules: [
    { token: 'comment', foreground: '6A9955' },
    { token: 'keyword', foreground: '569CD6' },
    { token: 'string', foreground: 'D4D4D4' },
    { token: 'delimiter.curly', foreground: 'FFD700' },
    { token: 'delimiter.square', foreground: 'FFD700' },
    { token: 'delimiter.round', foreground: 'FFD700' },
    { token: 'math', foreground: 'CE9178' }
  ],
  colors: {
    'editor.background': '#1E1E1E',
    'editor.foreground': '#D4D4D4',
    'editor.lineHighlightBackground': '#2A2A2A',
    'editorCursor.foreground': '#D4D4D4',
    'editor.lineNumbers': '#858585',
    'editor.selectionBackground': '#264F78',
    'editor.inactiveSelectionBackground': '#3A3D41',
  }
});


export default class extends Controller {
  connect() {
    console.log("Monaco Editor Controller is connected!");
    const latexTemplate = [
      "% LaTeX Editor - Start coding here",
      "\\documentclass[11pt]{article}",
      "",
      "\\begin{document}",
      "",
      "Hello, World!",
      "",
      "\\end{document}"
    ].join("\n");

    document.querySelectorAll('.application-add-new-btn').forEach(button => {
      const fieldType = button.dataset.fieldType;
      const formType = fieldType.replace('_id', '');
      console.log(formType);

      const editorId = `${formType}-editor`;
      const editorDiv = document.getElementById(editorId);

      const editor = monaco.editor.create(editorDiv, {
        value: "",
        language: "tex",
        theme: "latex-dark",
        automaticLayout: true,
        minimap: { enabled: false },
      });

      let debounceTimer;
      // This callback is triggered every time the content changes
      editor.onDidChangeModelContent((event) => {
        clearTimeout(debounceTimer);
        // Using debounce to wait 1 second before call again
        debounceTimer = setTimeout(() => {
          const latex = editor.getValue();
          const latexSourceFormField = document.getElementById(formType+"_latex_source");
          latexSourceFormField.value = latex;
          
          const formData = new FormData();
          formData.append('latex_source', latex);

          fetch('/preview', {
            method: 'POST',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: formData
          })
          .then(response => response.blob())
          .then(blob => {
            const url = URL.createObjectURL(blob);
            document.getElementById(formType+"-preview").src = `${url}#navpanes=0&toolbar=0&pagemode=none`;
          })
          .catch(console.error);
        }, 1000);
      });
      
      button.addEventListener('click', function() {
        const fieldType = this.dataset.fieldType;
        const formId = `new-${fieldType.replace('_id', '')}-form`;
        const form = document.getElementById(formId);
        form.classList.toggle('hidden');
        // Toggle pdf preview
        const previewId = `preview-${fieldType.replace('_id', '')}-div`;
        const previewDiv = document.getElementById(previewId);
        previewDiv.classList.toggle('hidden');
        this.textContent = this.textContent === 'Add New' ? 'Cancel' : 'Add New';
        if(editor.getValue() == "") {
          editor.setValue(latexTemplate);
        }
      });
    });
  }

  disconnect() {
    this.editor.dispose()
  }
}
