namespace :dev do
  desc "TODO"
  task setup: :environment do

    if Rails.env.development?
      puts %x(rails db:drop)
      puts %x(rails db:create) 
      puts %x(rails db:migrate) 
      puts %x(rails db:seed)
    else
      puts "Você não está em ambiente de desenvovimento!"
    end
    
  end
end
