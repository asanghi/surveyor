require 'surveyor/common.rb'
require 'surveyor/acts_as_response.rb'
require 'surveyor/surveyor_controller_methods.rb'
module Surveyor
  require 'surveyor/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end
