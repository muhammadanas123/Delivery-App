class SendersController < ApplicationController
    before_action :already_sender, only: [:new]
    before_action :sender_cannot_access_the_other_sender_info, only: [:edit, :show, :update, :destroy]
    before_action :restrict_index_action, only: [:index]
    before_action :restrict_traveller_to_access_sender
    before_action :find_and_set_sender, only: [:show, :edit, :update, :destroy]

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

    def show; end

    def edit; end

    def update
        if @sender.update(sender_params)
            redirect_to sender_path(@sender)
        else
            render "edit"
        end
    end

    def destroy
        @sender.destroy
        current_user_credential.destroy
        redirect_to new_user_credential_session_path
    end

    def index; end

    def traveller_list
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

    def find_and_set_sender
        @sender = Sender.find_by(id: params[:id])
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
end