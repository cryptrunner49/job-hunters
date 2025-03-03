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
    console.log("LaTeX Editor Controller is connected! - updated at " + new Date().toISOString())
    const resumeTemplate = [
      "\\setmainfont{Arial}",
      "\\setlength{\\parindent}{0pt}",
      "",
      "\\begin{document}",
      "\t",
      "\t\\begin{center}",
      "\t\t{\\LARGE \\textbf{{\\lbrack}Full Name{\\rbrack}}}\\\\[0.5em]",
      "\t\t{\\lbrack}Address{\\rbrack} $\\vert$ {\\lbrack}Phone Number{\\rbrack} $\\vert$ {\\lbrack}Email Address{\\rbrack} $\\vert$ {\\lbrack}LinkedIn/Website{\\rbrack}",
      "\t\\end{center}",
      "\t",
      "\t\\section*{Professional Summary}",
      "\t{\\lbrack}Brief professional summary highlighting key skills and experiences relevant to the job.{\\rbrack}",
      "\t",
      "\t\\section*{Experience}",
      "\t\\textbf{{\\lbrack}Job Title{\\rbrack}} \\hfill {\\lbrack}Start Date yyyy-MM-dd -- End Date yyyy-MM-dd{\\rbrack}\\\\",
      "\t{\\lbrack}Company Name{\\rbrack}, {\\lbrack}Location{\\rbrack}\\\\",
      "\t{\\lbrack}Brief description of role, responsibilities, and key achievements.{\\rbrack}",
      "\t",
      "\t\\vspace{0.5em}",
      "\t\\textbf{{\\lbrack}Job Title{\\rbrack}} \\hfill {\\lbrack}Start Date yyyy-MM-dd -- End Date yyyy-MM-dd{\\rbrack}\\\\",
      "\t{\\lbrack}Company Name{\\rbrack}, {\\lbrack}Location{\\rbrack}\\\\",
      "\t{\\lbrack}Brief description of role, responsibilities, and key achievements.{\\rbrack}",
      "\t",
      "\t\\section*{Education}",
      "\t\\textbf{{\\lbrack}Degree, e.g., Bachelor of Science in Computer Science{\\rbrack}} \\hfill {\\lbrack}Graduation Date yyyy-MM-dd{\\rbrack}\\\\",
      "\t{\\lbrack}University Name{\\rbrack}, {\\lbrack}Location{\\rbrack}",
      "\t",
      "\t\\section*{Skills}",
      "\t{\\lbrack}Bullet list of key skills: e.g., Programming Languages, Frameworks, Tools, etc.{\\rbrack}",
      "\t",
      "\t\\section*{Projects}",
      "\t\\textbf{{\\lbrack}Project Title{\\rbrack}} \\hfill {\\lbrack}Start Date yyyy-MM-dd -- End Date yyyy-MM-dd{\\rbrack}\\\\",
      "\t{\\lbrack}Brief description of the project, your role, and outcomes.{\\rbrack}",
      "",
      "\\end{document}"
    ].join("\n");
    const coverLetterTemplate = [
      "\\setmainfont{Arial}",
      "",
      "% Set sender details",
      "\\signature{{\\lbrack}Your Name{\\rbrack}}",
      "\\address{{\\lbrack}Your Address{\\rbrack}}",
      "\\date{{\\lbrack}yyyy-MM-dd{\\rbrack}}",
      "",
      "\\begin{document}",
      "\t",
      "\t\\begin{letter}{",
      "\t\t{\\lbrack}Recipient Name{\\rbrack}\\\\",
      "\t\t{\\lbrack}Recipient Title{\\rbrack}\\\\",
      "\t\t{\\lbrack}Company Name{\\rbrack}\\\\",
      "\t\t{\\lbrack}Company Address{\\rbrack}",
      "\t}",
      "\t",
      "\t\\opening{Dear {\\lbrack}Recipient Name{\\rbrack},}",
      "\t",
      "\t{\\lbrack}Introduction: Begin with a brief introduction stating the position you are applying for and how you learned about the opportunity.{\\rbrack}",
      "\t",
      "\t{\\lbrack}Body: Describe your relevant skills, experiences, and achievements. Explain why you are a strong fit for the role and how you can add value to the company.{\\rbrack}",
      "\t",
      "\t{\\lbrack}Closing: Express your enthusiasm for the opportunity, mention your availability for an interview, and thank the recipient for considering your application.{\\rbrack}",
      "\t",
      "\t\\closing{Sincerely,}",
      "\t",
      "\\end{letter}",
      "\\end{document}"
    ].join("\n");

    const fieldType = "resume";
    const formType = fieldType.replace('_id', '');

    const editorId = `${formType}-editor`;
    const editorDiv = document.getElementById(editorId);

    const editor = monaco.editor.create(editorDiv, {
      value: "",
      language: "tex",
      theme: "latex-dark",
      automaticLayout: true,
      minimap: { enabled: false },
      stickyScroll: {
        enabled: false
      },
    });

    // Add custom "Paste" action to context menu
    editor.addAction({
      id: "custom-paste", // Unique ID for the action
      label: "Paste",     // Text shown in the context menu
      contextMenuGroupId: "edit", // Group with other edit actions (e.g., Copy, Cut)
      contextMenuOrder: 1.5,      // Position in the menu (after Cut, before Copy)
      run: async (editor) => {
        try {
          const clipboardText = await navigator.clipboard.readText();
          const selection = editor.getSelection();
          editor.executeEdits('', [{
            range: selection,
            text: clipboardText,
            forceMoveMarkers: true
          }]);
          editor.focus();
        } catch (err) {
          console.error('Failed to read clipboard contents: ', err);
        }
      }
    });

    let debounceTimer;
    // This callback is triggered every time the content changes
    editor.onDidChangeModelContent((event) => {
      clearTimeout(debounceTimer);
      // Using debounce to wait 1 second before call again
      debounceTimer = setTimeout(() => {
        const latex = editor.getValue();
        const latexSourceFormField = document.getElementById(formType + "_latex_source");
        latexSourceFormField.value = latex;

        const formData = new FormData();
        formData.append('latex_source', latex);
        formData.append('type', formType);

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
            document.getElementById(formType + "-preview").src = `${url}#navpanes=0&toolbar=0&pagemode=none`;
          })
          .catch(console.error);
      }, 1000);
    });
  }

  disconnect() {
    this.editor.dispose();
    console.log("Latex editor disconnected");
  }
}
