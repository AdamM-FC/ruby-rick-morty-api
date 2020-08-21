class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  HOST = 'http://localhost:3000'.freeze
end
