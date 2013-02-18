class StatusesController < ApplicationController
  before_filter :can_write_orders
  before_filter :find_order
  
  def create
    @status = @order.statuses.build(params[:status].merge(:user_id => @current_user.id))

    expire_page formatted_order_path(@order, :pdf)
    
    if @status.factory_id?
      StatusMailer.deliver_profit(@status)
    end
    
    if @status.save
      flash[:notice] = "Successfully added a new status."
    else
      flash[:error] = "There was an error adding your status."
    end
    redirect_to order_path(@order)
  end
  
  protected
  
  def find_order
    @order = Order.find(params[:order_id])
  end
end
