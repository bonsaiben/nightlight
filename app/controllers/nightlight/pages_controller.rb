module Nightlight
  class PagesController < BaseController
    before_action :set_page, only: [:show, :edit, :update, :destroy, :assign, :unassign, :checked]
    before_action :authorize_assignee, only: [:unassign]

    def index
      @pages = Nightlight::Page.where(hidden: false).order('last_checked_at ASC')
      @new_pages = routes_pages.select do |r|
        Nightlight::Page.where(path: r[:path]).none?
      end

      if params[:all]
        @hidden_pages = Nightlight::Page.hidden
      end
    end

    def show
      @status = Nightlight::Activity.new
    end

    def edit
    end

    def new
      @page = Nightlight::Page.new
    end

    def create
      @page = Nightlight::Page.new page_params
      if @page.save
        flash[:success] = "Page saved."
        redirect_to page_url(@page)
      else
        flash.now[:error] = @page.errors.full_messages.first
        render 'nightlight/pages/new'
      end
    end

    def update
      if @page.update page_params
        flash[:success] = "Page updated."
        redirect_to page_url(@page)
      else
        flash.now[:error] = @page.errors.full_messages.first
        render 'nightlight/pages/edit'
      end
    end

    def destroy
      @page.destroy
      flash[:success] = "Page deleted."
      redirect_to root_url
    end

    def add_yes
      @page = Page.new page_params
      if @page.save
        flash[:success] = "Page added."
      else
        flash[:error] = @page.errors.full_messages.first
      end
      redirect_to root_url
    end

    def add_no
      @page = Page.new page_params
      @page.hidden = true
      if @page.save
        flash[:success] = "Settings saved."
      else
        flash[:error] = @page.errors.full_messages.first
      end
      redirect_to root_url
    end

    def assign
      if @page.assignee
        flash[:error] = "Someone is already assigned to this page"
        redirect_to page_url(@page)
        return
      end
      @page.assignee = current_user
      if @page.save
        flash[:success] = "You are now assigned to this page"
        redirect_to page_url(@page)
      else
        flash.now[:error] = @page.errors.full_messages.first
        render 'nightlight/pages/show'
      end
    end

    def unassign
      @page.assignee = nil
      if @page.save
        flash[:success] = "You are no longer assigned to this page"
        redirect_to page_url(@page)
      else
        flash.now[:error] = @page.errors.full_messages.first
        render 'nightlight/pages/show'
      end
    end

    def checked
      @page.checked! current_user
      flash[:success] = "Nice job"
      redirect_to page_url(@page)
    end

    def random
      scope = Nightlight::Page.unhidden.unassigned
      offset = rand(scope.count)
      @page = scope.offset(offset).first
      @page.update! assignee: current_user
      flash[:success] = "You are now assigned to this page"
      redirect_to page_url(@page)
    end

    private

    def routes_pages
      all_routes = Rails.application.routes.routes
      require 'action_dispatch/routing/inspector'
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
      routes = inspector.send(:collect_routes, all_routes)
      routes.select{|r| r[:verb]=="GET" }
    end

    def set_page
      @page = Nightlight::Page.find(params[:id].to_s.split("-").first)
    end

    def page_params
      params.require(:page).permit(:name, :path, :sample_path, :reqs, :notes, :hidden)
    end

    def authorize_assignee
      unless @page.assignee==current_user
        flash[:error] = "You are not assigned to this page"
        redirect_to page_url(@page)
      end
    end
  end
end
