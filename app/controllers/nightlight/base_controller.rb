module Nightlight
  class BaseController < ApplicationController
    # skip all filters
    skip_filter(*_process_action_callbacks.map(&:filter))

    helper Nightlight::Engine.helpers

    protect_from_forgery with: :exception

    if ENV["NIGHTLIGHT_PASSWORD"]
      http_basic_authenticate_with name: ENV["NIGHTLIGHT_USERNAME"], password: ENV["NIGHTLIGHT_PASSWORD"]
    end

    layout "nightlight/application"
  end
end
