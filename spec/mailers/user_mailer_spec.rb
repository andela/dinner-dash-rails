require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "sidekiq processed count should be increased by 1" do
    scenario "a user should receive a welcome mail on signup" do
      user = User.create(first_name: "jeff", last_name: "Mongo", email: "seyi@andela.com", password: "seyijeff",
      password_confirmation: "seyijeff", role: "user")

      expect {MailerWorker.perform_async(user.id)}.to change(MailerWorker.jobs, :size).by(1)
    end
  end
end