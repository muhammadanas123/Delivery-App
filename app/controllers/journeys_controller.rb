class JourneysController < ApplicationController
    # load_and_authorize_resource
    # before_action :traveller_cannot_access_the_other_traveller_info, only: [:edit, :show, :update, :destroy]
    before_action :find_and_set_journey, only: [:show, :edit, :update, :destroy]
    # before_action :restrict_sender_to_access_journey
    # before_action :set_traveller, only: [:new, :create, :index]

    def index
        @journeys = current_user.completed_journeys
        if can? :index, Journey
            render :index
        else
            flash["alert"] = "Not authorized to access Journey#index"
            redirect_to root_path
        end
    end

    def new
        @journey = current_user.journeys.build
        if can? :new, Journey
            render :new
        else
            flash["alert"] = "Not authorized to access Journey#new"
            redirect_to root_path
        end
    end

    def create 
        if can? :create, Journey
            @journey = current_user.journeys.build(journey_params)
            if @journey.save
                @journey.update(from: params[:journey][:from].downcase, to: params[:journey][:to].downcase)
                redirect_to journey_path(@journey), notice: "successfully created a journey"
            else
                render "new", alert: "there is some error while creating"
            end
        else
            flash["alert"] = "Not authorized to access Journey#create"
            redirect_to root_path
        end

    end

    def show
        if (@journey.present?) && (can? :show, Journey)
            render :show
        else
            flash["alert"] = "Not authorized to access Journey#show"
            redirect_to root_path
        end
    end

    def edit
        if (@journey.present?) && (can? :edit, Journey)
            render :edit
        else
            flash["alert"] = "Not authorized to access Journey#edit"
            redirect_to root_path
        end
    end

    def update
        if can? :update, Journey
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
                redirect_to journey_path(@journey), notice: "successfully updated your journey information!"
            end
        else
            flash["alert"] = "Not authorized to access Journey#update"
            redirect_to root_path
        end
    end

    def destroy
        if can? :update, Journey
            @journey.destroy
            redirect_to journeys_path
        else
            flash["alert"] = "Not authorized to access Journey#destroy"
            redirect_to root_path
        end
    end

    private

    def find_and_set_journey
        @journey = current_user.journeys.find_by(id: params[:id])
    end

    def journey_params
        params.require(:journey).permit(:from, :to, :departure_date, :arrival_date, :capacity, :rate, :status)
    end

    # def traveller_cannot_access_the_other_traveller_info
    #     if  current_user_credential.user_id != params[:traveller_id].to_i
    #         flash["notice"] = "you'r not authorised to access it."
    #         redirect_to root_path
    #     end
    # end

    # def restrict_sender_to_access_journey
    #     if current_user_credential.user_type == "Sender"
    #         flash["notice"] = "you'r not authorised to access it."
    #         redirect_to root_path
    #     end
    # end

    # def set_traveller
    #     @traveller = User.find_by(id: current_user.id)
    # end
end