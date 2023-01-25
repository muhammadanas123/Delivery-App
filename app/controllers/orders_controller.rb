class OrdersController < ApplicationController
    # before_action :restrict_traveller_to_access_orders
    # before_action :cannot_access_the_other_senders_orders
    # before_action :set_user, only: [:new, :create, :edit, :update, :index]
    before_action :find_and_set_orders, only: [:show, :destroy]
    # load_and_authorize_resource

    def index
        if current_user.has_role? :sender
            @orders = current_user.sender_orders
        elsif current_user.has_role? :traveller
            @orders = current_user.traveller_orders
        end
        
        if can? :index, Order
            render :index
        else
            flash["alert"] = "Not authorized to access Order#index"
            redirect_to root_path
        end
    end

    def new 
        @order = current_user.sender_orders.build
        session[:traveller_id] = params[:traveller_id].to_i
        if can? :new, Order
            render :new
        else
            flash["alert"] = "Not authorized to access Order#new"
            redirect_to root_path
        end
    end

    def create
        if can? :create, Order
            traveller_id = session[:traveller_id]
            @order = Order.new(order_params)
            @order.traveller_id = traveller_id
            @order.sender_id = current_user.id
            if @order.save
                redirect_to orders_path, notice: "successfully created an order"
            else
                render "new"
            end
        else
            flash["alert"] = "Not authorized to access Order#create"
            redirect_to root_path
        end
    end

    def edit
        @order = current_user.sender_orders.find_by(id: params[:id])
        if (@order.present?) && (can? :edit, Order)
            render :edit
        else
            flash["alert"] = "Not authorized to access Order#edit"
            redirect_to root_path
        end
    end

    def update
        if can? :update, Order
            @order = current_user.sender_orders.find_by(id: params[:id])
            if @order.update(order_params)
                redirect_to orders_path, notice: "successfully updated!"
            else
                render "edit"
            end
        else
            flash["alert"] = "Not authorized to access Order#update"
            redirect_to root_path
        end

    end



    def show
        if (@order.present?) && (can? :show, Order)
            render json: @order, include: [:items]
        else
            flash["alert"] = "Not authorized to access Order#show"
            redirect_to root_path
        end
    end

    def destroy
        if can? :destroy, Order
            @order.destroy
            redirect_to orders_path
        else
            flash["alert"] = "Not authorized to access Order#destroy"
            redirect_to root_path
        end
    end

    private
    def order_params
        params.require(:order).permit(:receiver_name, :receiver_phone, :receiver_address, items_attributes: [:id, :itemname, :_destroy])
    end

    def find_and_set_orders
        @order = (current_user.has_role? :sender) ? current_user.sender_orders.find_by(id: params[:id]) : current_user.traveller_orders.find_by(id: params[:id])
    end

    # def set_user
    #     @user = User.find_by(id: current_user.id)
    # end

    # def restrict_traveller_to_access_orders
    #     if current_user_credential.user_type == "Traveller"
    #         flash["alert"] = "you'r not authorised to access it."
    #         redirect_to root_path
    #     end
    # end

    # def cannot_access_the_other_senders_orders
    #     if current_user_credential.user_id != params[:sender_id].to_i
    #         flash["alert"] = "you can only access your own orders"
    #         redirect_to root_path
    #     end
    # end
end