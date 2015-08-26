class ApplicationMailer < ActionMailer::Base
  include ApplicationHelper

  default :from =>  "dinnerdashcafe@gmail.com"
  layout 'mailer'
end
