FactoryGirl.define do
  factory :user do
    first_name "jeff"
    last_name "Mongo"
    email "seyi@andela.com"
    password "seyijeff"
    password_confirmation "seyijeff"

    factory :another_user do
      email "Seyito@andela.com"
      password "daisiissoawesomeforwhere"
      password_confirmation "daisiissoawesome"
    end
    factory :admin do
      email "admin@andela.com"
      password "andela"
      password_confirmation "andela"
      role "admin"
    end
  end
end
