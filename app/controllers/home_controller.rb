class HomeController < ApplicationController
    def index; end

    def assign_role
        if params[:role] == 'traveller'
            current_user.add_role :traveller
        elsif params[:role] == 'sender'
            current_user.add_role :sender
        end

        redirect_to root_path
    end

    private
    def home_params
        params.require(:home).permit(:role)
    end

end