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

    private

    def enforce_current_user
      unless respond_to?(:current_user) && current_user
        flash[:error] = "This feature requires a logged in user."
        redirect_to root_url
      end
    end
  end
end
