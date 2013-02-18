class TestingsController < ApplicationController
  before_filter :admin_required
  
  before_filter :load_testing_associations, :only => %w{new edit create update}

  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @testings = Testing.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @testings }
    end
  end

  # New Options
  def new
    @testing = Testing.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @testing = Testing.find(params[:id])
  end

  # Create Options
  def create
    @testing = Testing.new(params[:testing])

    respond_to do |format|
      if @testing.save
        flash[:notice] = 'Testing was successfully created.'
        format.html { redirect_to(testings_url) }
        format.xml  { render :xml => @testing, :status => :created, :location => @testing }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @testing.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Update Options
  def update
    @testing = Testing.find(params[:id])

    respond_to do |format|
      if @testing.update_attributes(params[:testing])
        flash[:notice] = 'Testing was successfully updated.'
        format.html { redirect_to(testings_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @testing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @testing = Testing.find(params[:id])
    @testing.destroy

    respond_to do |format|
      format.html { redirect_to(testings_url) }
      format.xml  { head :ok }
    end
  end
  
  def load_testing_associations
    @countries = Country.find(:all)
  end
end
