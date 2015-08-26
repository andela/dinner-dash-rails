class ApplicationMailer < ActionMailer::Base
  include ApplicationHelper

  default :from =>  "alex.obogbare@andela.com"
  layout 'mailer'
end
