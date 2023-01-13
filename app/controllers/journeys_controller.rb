class JourneysController < ApplicationController
    before_action :traveller_cannot_access_the_other_traveller_info, only: [:edit, :show, :update, :destroy]
    before_action :find_and_set_journey, only: [:show, :edit, :update, :destroy]
    before_action :restrict_sender_to_access_journey
    before_action :set_traveller, only: [:new, :create, :index]

    def new
        @journey = @traveller.journeys.build
    end

    def create 
        @journey = @traveller.journeys.create(journey_params)
        @journey.update(from: params[:journey][:from].downcase, to: params[:journey][:to].downcase)
        redirect_to traveller_journeys_path(@traveller), notice: "successfully created a journey"
    end

    def show
    variable = Journey.not_completed_journey_id
    end

    def index
        @journeys = @traveller.journeys.completed_journies(current_user_credential.id)
    end

    def edit; end

    def update
        from = @journey.from
        to = @journey.to
        if !journey_params[:from].present? && !journey_params[:to].present?
            @journey.update(journey_params)
            @journey.update(from: from)
            @journey.update(to: to)
        elsif !journey_params[:from].present?
            @journey.update(journey_params)
            @journey.update(from: from)
        elsif !journey_params[:to].present?
            @journey.update(journey_params)
            @journey.update(to: to)
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
        redirect_to traveller_journeys_path(@traveller)
    end

    private

    def find_and_set_journey
        @traveller = Traveller.find_by(id: params[:traveller_id])
        @journey = @traveller.journeys.find_by(id: params[:id])
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

    def set_traveller
        @traveller = Traveller.find_by(id: params[:traveller_id])
    end
end