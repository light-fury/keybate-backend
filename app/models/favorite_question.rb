class FavoriteQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  after_create   :raise_question_score
  before_destroy :lower_question_score


  private

    def raise_question_score
      question = Question.find(self.question_id)
      score = question.score + 1
      if question.update_attributes(score: score)
        Pusher.trigger('updates', 'questions', {
          type: 'question',
          action: 'update',
          id: question.id,
          room_id: question.room_id,
          score: question.score,
          hidden: question.hidden,
          body: question.body,
          pinned_by_moderator: question.pinned_by_moderator,
          displayed: question.displayed
        })
      end
    end

    def lower_question_score
      question = Question.find(self.question_id)
      score = question.score - 1
      if question.update_attributes(score: score)
        Pusher.trigger('updates', 'questions', {
          type: 'question',
          action: 'update',
          id: question.id,
          room_id: question.room_id,
          score: question.score,
          hidden: question.hidden,
          body: question.body,
          pinned_by_moderator: question.pinned_by_moderator,
          displayed: question.displayed
        })
      end
    end
end
