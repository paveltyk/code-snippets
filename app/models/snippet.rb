class Snippet < ActiveRecord::Base
  TITLE_MAX_LENGTH = 60
  acts_as_taggable
  belongs_to :user
  validates_presence_of :code, :user_id

  def title
    if description.present?
      self.description.split("\n").first.chomp.mb_chars[(0...TITLE_MAX_LENGTH)].to_s
    else
      "Code Snippet ##{self.id}"
    end
  end
end
