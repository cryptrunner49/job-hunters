class PasswordsMailer < ApplicationMailer
  def reset(hunter)
    @hunter = hunter
    mail subject: "Reset your password", to: hunter.email_address
  end
end
