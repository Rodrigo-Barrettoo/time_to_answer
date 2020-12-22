module SiteHelper

  def mdg_jumbotron

    case params[:action]
    when "index"
      "Últimas perguntas cadastras..."
    when "questions"
      "Resutado para o termo: \"#{params[:term]}\"..."
    when "subject"
      "Mostrando questões com assunto: \"#{params[:subject]}\"..."
    end

  end
end
