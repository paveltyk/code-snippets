class Snippet < ActiveRecord::Base
  TITLE_MAX_LENGTH = 60
  acts_as_taggable
  belongs_to :user
  validates_presence_of :code, :user

  named_scope :with_description_like, lambda { |*args| { :conditions => conditions_array_for_description(args) } }

  def title
    if description.present?
      self.description.split("\n").first.chomp.mb_chars[(0...TITLE_MAX_LENGTH)].to_s
    else
      "Code Snippet ##{self.id}"
    end
  end

  def description_html
    return description if description.blank?
    RDiscount.new(description, :filter_html, :safelink, :no_pseudo_protocols, :smart, :autolink).to_html
  end

  def to_param
    "#{id} #{Transliterator.transliterate(title.to_s)}".parameterize
  end

  private

  def self.conditions_array_for_description(args)
    return [] if args.reject(&:blank?).blank?
    ["snippets.description #{self.match_operator} ?", args.first || '']
  end

  def self.match_operator
    case connection.adapter_name.downcase
      when 'postgresql': '~*'
      when 'mysql': 'REGEXP'
      else 'LIKE'
    end
  end
end
