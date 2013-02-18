class FactoriesController < ApplicationController
  before_filter :can_read_factories
  before_filter :can_destroy_factories,      :only => %w{destroy}
  before_filter :can_write_factories,        :only => %w{new edit create update}
  
  before_filter :load_factory_associations, :only => %w{new edit create update}
  
  # Index Options
  def index
    @factories = Factory.scoped({})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @factories }
      format.js do
        @factories = @factories.scoped(:conditions => { :country_id => params[:country_id] }) unless params[:country_id].blank?
      end
    end
  end

  def new
    @factory = Factory.new
    @factory.roles.build

    render :action => "edit"
  end
  
  # Create Options
  def create
    @factory = Factory.new(params[:factory])

    respond_to do |format|
      if @factory.save
        flash[:notice] = 'Factory was successfully created.'
        format.html { redirect_to(factories_url) }
        format.xml  { render :xml => @factory, :status => :created, :location => @factory }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @factory.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Edit Options
  def edit
    @factory = Factory.find(params[:id])
  end
  
  # Update Options
  def update
    @factory = Factory.find(params[:id])

    respond_to do |format|
      if @factory.update_attributes(params[:factory])
        flash[:notice] = 'Factory was successfully updated.'
        format.html { redirect_to(factories_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @factory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @factory = Factory.find(params[:id])
    @factory.destroy

    respond_to do |format|
      format.html { redirect_to(factories_url) }
      format.xml  { head :ok }
    end
  end
  
  def show
    @factory = Factory.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf
    end
  end
  
  private
  
  def update_factory
    @updated = @factory.update_attributes(params[:factory].reverse_merge("existing_role_attributes" => {}))
    true
  end
  
  def load_factories
    @factories = if params[:country_id].blank?
      Factory.find(:all, :order => "country, name")
    else
      Factory.find_all_by_country(params[:country], :order => "country, name")
    end
  end
  
  def load_factory_associations
    @countries = Country.find(:all)
 end
end