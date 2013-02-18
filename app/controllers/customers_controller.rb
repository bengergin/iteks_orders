class CustomersController < ApplicationController
  before_filter :can_read_customers
  before_filter :can_destroy_customers,      :only => %w{destroy}
  before_filter :can_write_customers,        :only => %w{new edit create update}
  
  # Index Options
  def index
    if @current_user.admin?
      @customers = Customer.find(:all)
    else
      @customers = @current_user.customers
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # New Options
  def new
    @customer = Customer.new
    @customer.roles.build

    render :action => "edit"
  end

  # Edit Options
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  # Create Options
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        flash[:notice] = 'Customer was successfully created.'
        format.html { redirect_to(customers_url) }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        flash[:notice] = 'Customer was successfully updated.'
        format.html { redirect_to(customers_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def update_customer
    @updated = @customer.update_attributes(params[:customer].reverse_merge("existing_role_attributes" => {}))
    true
  end
end