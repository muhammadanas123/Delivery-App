class JourneysController < ApplicationController

    before_action :traveller_cannot_access_the_other_traveller_info, only: [:edit, :show, :update, :destroy]
    before_action :find_and_set_journey, only: [:show, :edit, :update, :destroy]
    before_action :restrict_sender_to_access_journey


    def new
        # byebug
        @traveller = Traveller.find(params[:traveller_id])
        @journey = @traveller.journeys.build

    end

    def create 
        @traveller = Traveller.find(params[:traveller_id])
        @journey = @traveller.journeys.create(journey_params)
        redirect_to traveller_journeys_path(@traveller, @journey), notice: "successfully created a journey"
        # render json: @journey

    end

    def show


    end


    def index
        # byebug
        @traveller = Traveller.find(params[:traveller_id])
        @journeys = @traveller.journeys
    end

    def edit

    end

    def update
        # byebug
        from = @journey.from
        to = @journey.to

        if journey_params[:from] == "" && journey_params[:to] == ""
            @journey.update(from: from, to: to, departure_date: journey_params[:departure_date], arrival_date: journey_params[:arrival_date], capacity: journey_params[:capacity], rate: journey_params[:rate])
        elsif journey_params[:from] == ""
            @journey.update(from: from, to: journey_params[:to], departure_date: journey_params[:departure_date], arrival_date: journey_params[:arrival_date], capacity: journey_params[:capacity], rate: journey_params[:rate])
        elsif journey_params[:to] == ""
            @journey.update(from: journey_params[:from], to: to, departure_date: journey_params[:departure_date], arrival_date: journey_params[:arrival_date], capacity: journey_params[:capacity], rate: journey_params[:rate])
        else
            @journey.update(journey_params)
        end


        if @journey.errors.any?
            render "edit"
        else
            redirect_to traveller_journey_path(@traveller,@journey), notice: "successfully updated your journey information!"
        end

    end

    def destroy
        @journey.destroy
        redirect_to traveller_journeys_path

    end





    private

    def find_and_set_journey
        @traveller = Traveller.find(params[:traveller_id])
        @journey = @traveller.journeys.find(params[:id])

    end

    def journey_params
        params.require(:journey).permit(:from, :to, :departure_date, :arrival_date, :capacity, :rate)
    end




    def traveller_cannot_access_the_other_traveller_info
        if  current_user_credential.user_id != params[:traveller_id].to_i
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end

    def restrict_sender_to_access_journey
        if current_user_credential.user_type == "Sender"
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end
end