class OrdersController < ApplicationController
    before_action :restrict_traveller_to_access_orders
    before_action :cannot_access_the_other_senders_orders
    # before_action :cannot_edit_traveller_id_from_url, except: [:new]



    def new 
        # byebug
        @sender = Sender.find(params[:sender_id])
        @order = @sender.orders.build
        session[:traveller_id] = params[:traveller_id].to_i

    end

    def create
        # byebug
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

    def edit
        # byebug
        @sender = Sender.find(params[:sender_id])
        @order = @sender.orders.find(params[:id])
    end

    def update
        @sender = Sender.find(params[:sender_id])
        @order = @sender.orders.find(params[:id])
        if @order.update(order_params)
            redirect_to sender_order_path(@order), notice: "successfully updated!"
        else
            render "edit"
        end
    end

    def index
        @sender = Sender.find(params[:sender_id])
        @orders = @sender.orders
    end

    def show
        @order = Order.find(param[:id])
    end

    def destroy
        @order = Order.find(params[:id])
        @order.destroy
        redirect_to sender_orders_path

    end




    private
    def order_params
        params.require(:order).permit(:receiver_name, :receiver_phone, :receiver_address, items_attributes: [:id, :itemname, :_destroy])
    end

    def restrict_traveller_to_access_orders
        if current_user_credential.user_type == "Traveller"
            flash["alert"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end

    
    def cannot_access_the_other_senders_orders
        if  current_user_credential.user_id != params[:sender_id].to_i
            flash["alert"] = "you'r not authorised to access it."
            redirect_to root_path
        end
    end

    def cannot_edit_traveller_id_from_url
        if session[:traveller_id] != params[:traveller_id].to_i
            flash["alert"] = "you cannot edit the traveller id from url."
            redirect_to traveller_list_path
        end
    end




end