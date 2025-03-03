import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("Cover Letter Preview connected!");
        const coverLetterSelectElement = document.getElementById("job_application_cover_letter_id");
        let coverLetterName;

        coverLetterSelectElement.addEventListener('change', function () {
            coverLetterName = coverLetterSelectElement[coverLetterSelectElement.value].text;
            const formType = "cover_letter";

            const formData = new FormData();
            formData.append('cover_letter_name', coverLetterName);

            fetch('/preview_cover_letter', {
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
        });
    }

    disconnect() {

    }
}
