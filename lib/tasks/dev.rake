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

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do

    Subject.all.each do |subject|

      rand(5..10).times do |i|
        params = create_questions_params(subject = Subject.all.sample)
        answers_array = params[:question][:answers_attributes]

        add_answers(answers_array)
        elect_true_answers(answers_array)

        Question.create!(params[:question])
      end

    end

  end

  desc "Reseta contador dos assuntos"
  task reset_subject_counter: :environment do

    Subject.all.each do |subject|

      Subject.reset_counters(subject.id, :questions)

    end
  end

  private

  def create_answers_params(correct = false)
    {
      description: Faker::Lorem.sentence,
      correct: correct
    }
  end

  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(create_answers_params)
    end
  end

  def elect_true_answers(answers_array = [])
    selected_index = rand(answers_array.size)
    answers_array[selected_index] = create_answers_params(true)
  end

  def create_questions_params(subject)
    {
      question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end

end
