class HomeController < ApplicationController
    def index; end

    def assign_role
        current_user.add_role params[:role]
        redirect_to root_path
    end
end