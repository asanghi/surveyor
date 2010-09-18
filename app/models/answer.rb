class Answer < ActiveRecord::Base

  # Associations
  belongs_to :question
  has_many :responses

  # Scopes
  default_scope order("display_order ASC")
  
  # Validations
  validates :text, :presence => true
  validates :question_id, :numericality => {:only_integer => true}
  
  # Methods
  def renderer(q = question)  
    r = [q.pick.to_s, self.response_class].compact.map(&:downcase).join("_")
    r.blank? ? :default : r.to_sym
  end
  
end
