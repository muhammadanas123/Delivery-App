class Users::ManagesController < ApplicationController

    def profile
        render template: "users/show"
    end

    def traveller_list
        if params[:from].present? && params[:to].present? && params[:capacity].present?
            @journeys = Journey.search(params[:from], params[:to], params[:capacity])
            render "users/traveller_list"

        else
            flash.now[:alert] = "you'r missing some fields"
            render "users/traveller_list"
        end
    end
end