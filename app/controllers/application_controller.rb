class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
            format.json { render nothing: true, status: :not_found }
            format.html { redirect_to main_app.root_url, notice: exception.message, status: :not_found }
            format.js   { render nothing: true, status: :not_found }
        end
    end

    # protected
    # def restrict_index_action
    #     if params[:action] == "index"
    #         redirect_to root_path, notice: "you'r not authorised to access it."
    #     end
    # end
end
