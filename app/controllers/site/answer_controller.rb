class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer_id])

    if user_signed_in?
      user_statistic = UserStatistic.find_or_create_by(user: current_user)
      if @answer.correct?
        user_statistic.right_questions += 1
      else
        user_statistic.wrong_questions += 1
      end

      user_statistic.save
    end
  end
end
