class ExampleMailerPreview < ActionMailer::Preview
 def welcome_email_preview
   ExampleMailer.welcome_email(User.first)
 end
end