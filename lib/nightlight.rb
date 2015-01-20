require "nightlight/version"
require "nightlight/engine"

module Nightlight
  class << self
    attr_accessor :user_name
  end
  self.user_name = :name
end
