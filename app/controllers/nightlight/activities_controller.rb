module Nightlight
  class ActivitiesController < BaseController

    before_action :set_page

    def create
      @status = @page.activities.status.new activity_params
      @status.user = current_user if respond_to?(:current_user)
      if @status.save
        flash[:success] = "Status updated."
        redirect_to page_url(@page)
      else
        flash.now[:error] = @status.errors.full_messages.first
        render 'nightlight/pages/show'
      end
    end

    private

    def set_page
      @page = Nightlight::Page.find(params[:page_id].to_s.split("-").first)
    end

    def activity_params
      params.require(:activity).permit(:description)
    end

  end
end
