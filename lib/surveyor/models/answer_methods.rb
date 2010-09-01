module Surveyor
  module Models
    module AnswerMethods
      def self.included(base)
        # Associations
        base.send :belongs_to, :question
        base.send :has_many, :responses
        base.send :has_many, :validations, :dependent => :destroy
        
        # Scopes
        base.send :default_scope, :order => "display_order ASC"

        # Validations
        base.send :validates_presence_of, :text
        base.send :validates_numericality_of, :question_id, :allow_nil => false, :only_integer => true
      end

      # Instance Methods
      def renderer(q = question)  
        r = [q.pick.to_s, self.response_class].compact.map(&:downcase).join("_")
        r.blank? ? :default : r.to_sym
      end
    end
  end
end