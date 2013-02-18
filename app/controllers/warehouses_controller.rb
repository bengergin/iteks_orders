class WarehousesController < ApplicationController
  before_filter :can_read_warehouses
  before_filter :can_write_warehouses, :only => %{new edit create update}
  before_filter :can_destroy_warehouses, :only => :destroy
  
  # Index Options
  def index
    @warehouses = Warehouse.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @warehouses }
    end
  end

  # New Options
  def new
    @warehouse = Warehouse.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @warehouse = Warehouse.find(params[:id])
    @departments = Department.find(:all)
  end
  
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  # Create Options
  def create
    @warehouse = Warehouse.new(params[:warehouse])

    respond_to do |format|
      if @warehouse.save
        flash[:notice] = 'Warehouse was successfully created.'
        format.html { redirect_to(warehouses_url) }
        format.xml  { render :xml => @warehouse, :status => :created, :location => @warehouse }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @warehouse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @warehouse = Warehouse.find(params[:id])

    respond_to do |format|
      if @warehouse.update_attributes(params[:warehouse])
        flash[:notice] = 'Warehouse was successfully updated.'
        format.html { redirect_to(warehouses_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @warehouse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy

    respond_to do |format|
      format.html { redirect_to(warehouses_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def customer
    @warehouses = Customer.find(params[:id]).warehouses
    render :partial => "option", :collection => @warehouses
  end
end