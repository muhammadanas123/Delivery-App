class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    protected
    def restrict_index_action
        if params[:action] == "index"
            redirect_to root_path, notice: "you'r not authorised to access it."
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :phone_no, :landline, :city, :state, :country])
    end
end
