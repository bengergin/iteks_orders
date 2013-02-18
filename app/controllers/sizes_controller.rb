class SizesController < ApplicationController
  before_filter :admin_required
  before_filter :load_size_associations, :only => %w{new edit create update amend}
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @sizes = Size.scoped(:order => "department_id, subscript")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sizes }
      format.js do
        @sizes = @sizes.scoped(:conditions => { :department_id => params[:department_id] }) unless params[:department_id].blank?
        render :layout => false
      end
    end
  end

  # New Options
  def new
    @size = Size.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @size = Size.find(params[:id])
    @departments = Department.find(:all)
  end

  # Create Options
  def create
    @size = Size.new(params[:size])

    respond_to do |format|
      if @size.save
        flash[:notice] = 'Size was successfully created.'
        format.html { redirect_to(sizes_url) }
        format.xml  { render :xml => @size, :status => :created, :location => @size }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @size.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @size = Size.find(params[:id])

    respond_to do |format|
      if @size.update_attributes(params[:size])
        flash[:notice] = 'Size was successfully updated.'
        format.html { redirect_to(sizes_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @size.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @size = Size.find(params[:id])
    @size.destroy

    respond_to do |format|
      format.html { redirect_to(sizes_url) }
      format.xml  { head :ok }
    end
  end
  
  def load_size_associations
    @departments = Department.find(:all, :order => 'name')
  end
end
