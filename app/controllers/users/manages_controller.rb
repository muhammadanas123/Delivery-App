class Users::ManagesController < ApplicationController

    def profile
        
        render template: "users/show"

    end

    def traveller_list
        if params[:from].present? && params[:to].present? && params[:capacity].present?
            @journeys = Journey.search(params[:from], params[:to], params[:capacity])
            render "users/traveller_list"

        else
            flash.now["notice"] = "you'r missing some fields"
            render "users/traveller_list"
        end
    end

    private
    def sender_params
        params.require(:manages).permit(:from, :to, :capacity)
    end
end