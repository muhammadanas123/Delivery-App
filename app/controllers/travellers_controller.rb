class TravellersController < ApplicationController
    before_action :already_traveller, only: [:new]

    include TravellerHelper



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

    def show
        @traveller = Traveller.find(current_user_credential.user_id)
    end

    def edit
        @traveller = Traveller.find(params[:id])
    end

    def update
        @traveller = Traveller.find(params[:id])
        if @traveller.update(traveller_params)
            redirect_to traveller_path(@traveller)
        else
            render "edit"

        end

    end

    def destroy
        byebug
        @traveller = Traveller.find(params[:id])
        @traveller.destroy
        current_user_credential.destroy
        redirect_to root_path
        
    end



    private
    def traveller_params
        params.require(:traveller).permit(:firstname, :lastname, :phone_no, :landline, :city, :country, :state)

    end

    def already_traveller
        if current_user_credential.user_type == "Traveller"
            flash["notice"] = "you'r already a traveller"
            redirect_to root_path

        end
    end

end