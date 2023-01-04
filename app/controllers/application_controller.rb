class ApplicationController < ActionController::Base
    before_action :authenticate_user_credential!

    private
    def restrict_index_action
        if params[:action] == "index"
            redirect_to root_path, notice: "you'r not authorised to access it."
        end
    end
end
