class OrdersController < ApplicationController


    def new 
        # byebug
        @sender = Sender.find(params[:sender_id])
        @order = @sender.orders.build
        session[:traveller_id] = params[:traveller_id].to_i

    end

    def create
        byebug
        @sender = Sender.find(params[:sender_id])
        @traveller_id = session[:traveller_id]
        @order = Order.new(order_params)
        @order.traveller_id = @traveller_id
        @order.sender_id = params[:sender_id]
        # @order = Order.create(, sender_id: params[:sender_id].to_i, receiver_name: params[:order][:receiver_name], receiver_phone:  params[:order][:receiver_phone], receiver_address:  params[:order][:receiver_address])
        if @order.save
            redirect_to sender_orders_path, notice: "successfully created an order"
        else
            render "new"
        end

    end

    def index
        @sender = Sender.find(params[:sender_id])
        @orders = @sender.orders
    end




    private
    def order_params
        params.require(:order).permit(:receiver_name, :receiver_phone, :receiver_address, items_attributes: [:id, :itemname, :_destroy])
    end




end