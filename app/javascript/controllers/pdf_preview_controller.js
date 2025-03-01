import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {

    /*
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
    */
    const formType = "resume";
    //const latex = coverLetterTemplate;
    const latexSourceFormField = document.getElementById("resume-source");
    //latexSourceFormField.value = latex;
    console.log(latexSourceFormField);
    console.log(latexSourceFormField.innerText);
    const latex = latexSourceFormField.innerText;    
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
            document.getElementById(formType+"-preview").src = `${url}#navpanes=0&toolbar=0&pagemode=none`;})
            .catch(console.error);
  }

      disconnect() {
        this.editor.dispose()
      }
    }
    