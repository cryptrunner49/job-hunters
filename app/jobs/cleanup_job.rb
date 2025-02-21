# app/jobs/cleanup_job.rb
class CleanupJob < ApplicationJob
  queue_as :default

  def perform(pdf_path)
    temp_dir = File.dirname(pdf_path)
    FileUtils.rm_rf(temp_dir) if Dir.exist?(temp_dir)
  end
end
