import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const formType = "cover_letter";
    const latexSourceFormField = document.getElementById("cover_letter-source");
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
        document.getElementById(formType + "-preview").src = `${url}#navpanes=0&toolbar=0&pagemode=none`;
      })
      .catch(console.error);
  }

  disconnect() {
  }
}
