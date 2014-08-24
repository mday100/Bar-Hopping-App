class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :comment_votes
  validates :body, presence: true

  RATIO = ["girls", "guys", "unknown"]

  def whats_ratio
    RATIO[self.ratio]
  end

  def self.by_votes
  	select('comments.*, coalesce(value, 0) as votes').
  	joins('left join comment_votes on comment_id=comments.id').
  	order('votes desc')
  end

  def votes
  	read_attribute(:votes) || comment_votes.sum(:value)
  end
end