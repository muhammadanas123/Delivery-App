class JourneysController < ApplicationController

    before_action :traveller_cannot_access_the_other_traveller_info, only: [:edit, :show, :update, :destroy]


    def new
        # byebug
        @traveller = Traveller.find(params[:traveller_id])
        @journey = @traveller.journeys.build

    end

    def create 
        @traveller = Traveller.find(params[:traveller_id])
        @journey = @traveller.journeys.create(journey_params)
        redirect_to traveller_journey_path(@traveller, @journey), notice: "successfully created a journey"
        # render json: @journey

    end

    def show
        @traveller = Traveller.find(params[:traveller_id])
        @journey = @traveller.journeys.find(params[:id])

    end


    def index
        # byebug
        @traveller = Traveller.find(params[:traveller_id])
        @journeys = @traveller.journeys
    end

    def edit

    end

    def update

    end

    def destroy

    end





    private

    def journey_params
        params.require(:journey).permit(:from, :to, :departure_date, :arrival_date, :capacity, :rate)
    end


    def traveller_cannot_access_the_other_traveller_info
        if  current_user_credential.user_id != params[:traveller_id].to_i
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end
end