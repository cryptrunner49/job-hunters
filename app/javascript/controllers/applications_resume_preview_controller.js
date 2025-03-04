import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("Resume Preview connected!");
        const resumeSelectElement = document.getElementById("job_application_resume_id");
        let resumeName;

        resumeSelectElement.addEventListener('change', function () {
            resumeName = resumeSelectElement[resumeSelectElement.value].text;
            const formType = "resume";

            const formData = new FormData();
            formData.append('resume_name', resumeName);

            fetch('/preview_resume', {
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

        resumeName = resumeSelectElement[resumeSelectElement.value].text;
        const formType = "resume";

        const formData = new FormData();
        formData.append('resume_name', resumeName);

        fetch('/preview_resume', {
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
