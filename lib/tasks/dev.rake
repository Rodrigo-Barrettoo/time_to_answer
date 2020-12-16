namespace :dev do

  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "TODO"
  task setup: :environment do

    if Rails.env.development?
      puts %x(rails db:drop)
      puts %x(rails db:create) 
      puts %x(rails db:migrate) 
      puts %x(rails db:seed)

      puts %x(rails dev:add_subjects)
      puts %x(rails dev:add_answers_and_questions)
    else
      puts "Você não está em ambiente de desenvovimento!"
    end
  end

  desc "Adiciona assuntos padrão"  
  task add_subjects: :environment do

    file_name = 'subjects.txt'    
    file_path = File.join(DEFAULT_FILES_PATH, file_name)  

    File.open(file_path, 'r').each do |line|      
      Subject.create!(description: line.strip)    
    end  

  end

  desc "Adiciona perhuntas e respostas"  
  task add_answers_and_questions: :environment do 

    Subject.all.each do |subject|

      rand(5..10).times do |i|
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject 
        )
      end
      
    end

  end
end
