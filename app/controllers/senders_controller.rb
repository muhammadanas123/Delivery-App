class SendersController < ApplicationController
    before_action :already_sender, only: [:new]
    before_action :sender_cannot_access_the_other_sender_info, only: [:edit, :show, :update, :destroy]
    before_action :restrict_index_action, only: [:index]
    before_action :restrict_traveller_to_access_sender

    # include TravellerHelper



    def new
        @sender = Sender.new
    end

    def create
        @sender = Sender.new(sender_params)
        if @sender.save
            current_user_credential.user = @sender
            current_user_credential.save
            redirect_to sender_path(@sender)
        else
            render "new"

        end


    end

    def show
        @sender = Sender.find(current_user_credential.user_id)
        # byebug
    end

    def edit
        @sender = Sender.find(params[:id])
    end

    def update
        @sender = Sender.find(params[:id])
        if @sender.update(sender_params)
            redirect_to sender_path(@sender)
        else
            render "edit"

        end

    end

    def destroy
        byebug
        @sender = Sender.find(params[:id])
        @sender.destroy
        current_user_credential.destroy
        redirect_to root_path
        
    end

    def index
        byebug
    end

    def traveller_list
        # byebug
        if params[:from].present? && params[:to].present? && params[:capacity].present?
            @journeys = Journey.search(params[:from], params[:to], params[:capacity])
        else
            flash.now["notice"] = "you'r missing some fields"
            render "traveller_list"
        end

    end



    private
    def sender_params
        params.require(:sender).permit(:firstname, :lastname, :phone_no, :landline, :city, :country, :state, :from, :to, :capacity)

    end

    def already_sender
        if current_user_credential.user_type == "Sender"
            flash["notice"] = "you'r already a sender"
            redirect_to root_path

        end
    end

    def sender_cannot_access_the_other_sender_info
        if  current_user_credential.user_id != params[:id].to_i
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end

    def restrict_traveller_to_access_sender
        if current_user_credential.user_type == "Traveller"
            flash["notice"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end




    def restrict_index_action
        if params[:action] == "index"
            redirect_to root_path, notice: "you'r not authorised to access it."
        end
    end

end