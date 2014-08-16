class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :comment_votes

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

  def total_votes
  	CommentVote.joins(:comment).where(comment: { user_id: self.id }).sum('value')
  end

  def can_vote_for?(comment)
  	comment_votes.build(value: 1, comment: comment).valid?
  end
end