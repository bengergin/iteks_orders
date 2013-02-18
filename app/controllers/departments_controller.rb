class DepartmentsController < ApplicationController
  before_filter :admin_required
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @departments = Department.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @departments }
    end
  end

  # New Options
  def new
    @department = Department.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @department = Department.find(params[:id])
  end

  # Create Options
  def create
    @department = Department.new(params[:department])

    respond_to do |format|
      if @department.save
        flash[:notice] = 'Department was successfully created.'
        format.html { redirect_to(departments_url) }
        format.xml  { render :xml => @department, :status => :created, :location => @department }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(params[:department])
        flash[:notice] = 'Department was successfully updated.'
        format.html { redirect_to(departments_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to(departments_url) }
      format.xml  { head :ok }
    end
  end
end
