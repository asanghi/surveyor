class Validation < ActiveRecord::Base

  # Associations
  belongs_to :answer
  has_many :validation_conditions
  
  # Scopes
  
  # Validations
  validates :rule, :presence => true, :format => {:with => /^(?:and|or|\)|\(|[A-Z]|\s)+$/}
  validates :answer_id, :numericality => true
  
  # Instance Methods
  def is_valid?(response_set)
    ch = conditions_hash(response_set)
    rgx = Regexp.new(self.validation_conditions.map{|vc| ["a","o"].include?(vc.rule_key) ? "#{vc.rule_key}(?!nd|r)" : vc.rule_key}.join("|")) # exclude and, or
    # logger.debug "v: #{self.inspect}"
    # logger.debug "rule: #{self.rule.inspect}"
    # logger.debug "rexp: #{rgx.inspect}"
    # logger.debug "keyp: #{ch.inspect}"
    # logger.debug "subd: #{self.rule.gsub(rgx){|m| ch[m.to_sym]}}"
    eval(self.rule.gsub(rgx){|m| ch[m.to_sym]})
  end
  
  # A hash of the conditions (keyed by rule_key) and their evaluation (boolean) in the context of response_set
  def conditions_hash(response_set)
    hash = {}
    response = response_set.responses.detect{|r| r.answer_id.to_i == self.answer_id.to_i}
    # logger.debug "r: #{response.inspect}"
    self.validation_conditions.each{|vc| hash.merge!(vc.to_hash(response))}
    return hash
  end
end