require 'rails'
require 'surveyor'
require 'surveyor/common.rb'
require 'surveyor/acts_as_response.rb'
require 'surveyor/surveyor_controller_methods.rb'

module Surveyor
  class Engine < Rails::Engine
    rake_tasks do
      load "tasks/surveyor_tasks.rake"
    end
  end
end
