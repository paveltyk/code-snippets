class Relationship < ActiveRecord::Base
  belongs_to :follower, :class_name => 'User'
  belongs_to :followed, :class_name => 'User'

  validates_presence_of :follower, :followed
  validate :follower_not_equal_to_followed

  private

  def follower_not_equal_to_followed
    return if [follower, followed].any?(&:blank?)
    errors.add_to_base("Follower and Followed can't be the same person") if follower == followed
  end

end