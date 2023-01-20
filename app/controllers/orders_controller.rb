class OrdersController < ApplicationController
    before_action :restrict_traveller_to_access_orders
    before_action :cannot_access_the_other_senders_orders
    before_action :set_sender, only: [:new, :create, :edit, :update, :index]
    before_action :find_and_set_orders, only: [:show, :destroy]

    def new 
        @order = @sender.orders.build
        session[:traveller_id] = params[:traveller_id].to_i
    end

    def create
        @traveller_id = session[:traveller_id]
        @order = Order.new(order_params)
        @order.traveller_id = @traveller_id
        @order.sender_id = params[:sender_id]
        if @order.save
            redirect_to sender_orders_path, notice: "successfully created an order"
        else
            render "new"
        end
    end

    def edit
        @order = @sender.orders.find_by(id: params[:id])
    end

    def update
        @order = @sender.orders.find_by(id: params[:id])
        if @order.update(order_params)
            redirect_to sender_orders_path, notice: "successfully updated!"
        else
            render "edit"
        end
    end

    def index
        @orders = @sender.orders
    end

    def show
        render json: @order, include: [:items]
    end

    def destroy
        @order.destroy
        redirect_to sender_orders_path
    end

    private
    def order_params
        params.require(:order).permit(:receiver_name, :receiver_phone, :receiver_address, items_attributes: [:id, :itemname, :_destroy])
    end

    def find_and_set_orders
        @order = Order.find_by(id: params[:id])
    end

    def set_sender
        @sender = Sender.find_by(id: params[:sender_id])
    end

    def restrict_traveller_to_access_orders
        if current_user_credential.user_type == "Traveller"
            flash["alert"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end

    def cannot_access_the_other_senders_orders
        if current_user_credential.user_id != params[:sender_id].to_i
            flash["alert"] = "you can only access your own orders"
            redirect_to root_path
        end
    end
end