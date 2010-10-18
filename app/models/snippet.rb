class Snippet < ActiveRecord::Base
  TITLE_MAX_LENGTH = 60
  belongs_to :user

  def title
    self.description.try(:split, "\n").try(:first).try(:[], (0...TITLE_MAX_LENGTH)) || "Code Snippet ##{self.id}"
  end
end
