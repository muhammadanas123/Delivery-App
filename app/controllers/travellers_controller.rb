class TravellersController < ApplicationController
    before_action :already_traveller, only: [:new]
    before_action :traveller_cannot_access_the_other_traveller_info, only: [:edit, :show, :update, :destroy]
    before_action :restrict_index_action, only: [:index]
    before_action :restrict_sender_to_access_traveller
    before_action :find_and_set_traveller, only: [:show, :edit, :update, :destroy]

    def new
        @traveller = Traveller.new
    end

    def create
        @traveller = Traveller.new(traveller_params)
        if @traveller.save
            current_user_credential.user = @traveller
            current_user_credential.save
            redirect_to traveller_path(@traveller)
        else
            render "new"
        end
    end

    def show; end

    def index; end

    def edit; end

    def update
        if @traveller.update(traveller_params)
            redirect_to traveller_path(@traveller)
        else
            render "edit"
        end
    end

    def orders
        @traveller = Traveller.find_by(id: params[:traveller_id])
        @orders = @traveller.orders
    end

    def destroy
        @traveller.destroy
        current_user_credential.destroy
        redirect_to root_path
        
    end

    private
    def traveller_params
        params.require(:traveller).permit(:firstname, :lastname, :phone_no, :landline, :city, :country, :state)
    end

    def find_and_set_traveller
        @traveller = Traveller.find_by(id: params[:id])
    end

    def already_traveller
        if current_user_credential.user_type == "Traveller"
            flash["notice"] = "you'r already a traveller"
            redirect_to root_path
        end
    end

    def traveller_cannot_access_the_other_traveller_info
        if  current_user_credential.user_id != params[:id].to_i
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end

    def restrict_sender_to_access_traveller
        if current_user_credential.user_type == "Sender"
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end
end