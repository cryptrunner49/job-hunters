# JobHunters: Your Ultimate Job Hunting Companion Web App

JobHunters is a modern web application designed to help job seekers organize their job search, track cold job applications, and stay on top of opportunities. Whether you're applying for multiple roles, preparing for interviews, or following up with recruiters, JobHunters provides an intuitive and streamlined solution to manage your job hunt effectively.  

## Running on Docker

```bash
git clone https://github.com/cryptrunner49/job-hunters
cd job-hunters
sudo docker compose up
Available in: http://localhost/
```

## Running without Docker

to run without docker you need to have ruby 3.3.6 installed.

```bash
git clone https://github.com/cryptrunner49/job-hunters
cd job-hunters
bin/rails db:migrate
bin/dev
Available in: http://localhost:3000/
```

## 🌟 Key Features  

✅ **Application Tracking** – Keep track of all your job applications in one place, including company names, job titles, and application statuses.  

✅ **Interview Scheduling** – Schedule and manage upcoming interviews, set reminders, and add important details like interviewers' names and meeting links.  

✅ **Resume & Cover Letter Management** – Upload and organize resumes and cover letters tailored to specific job applications.  

✅ **Networking Tracker** – Log interactions with recruiters, hiring managers, and professional contacts to stay connected and follow up.  

✅ **Job Search Insights** – Get an overview of your job search progress, including application response rates and interview success trends.  

✅ **Responsive UI** – Fully functional across desktop and mobile devices, so you can manage your job hunt on the go.  

## 🚀 Tech Stack  

- **Fullstack**: Ruby on Rails, TailwindCSS for styling
- **Database**: Sqlite3
- **Authentication**: Rails Auth

## 📌 Why JobHunters?

Job hunting can be overwhelming, but it doesn’t have to be. JobHunters simplifies the process by combining application tracking, interview scheduling, into a seamless, web-based experience. Stay organized, focused, and ahead of the competition with JobHunters!
