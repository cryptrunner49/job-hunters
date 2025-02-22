// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";// Optional theme

console.log("application.js is running!");

if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    document.documentElement.className = 'dark';
} else {
    document.documentElement.className = 'light';
}
