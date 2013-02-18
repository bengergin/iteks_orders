class CountriesController < ApplicationController
  before_filter :admin_required
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @countries = Country.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # New Options
  def new
    @country = Country.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @country = Country.find(params[:id])
  end

  # Create Options
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        flash[:notice] = 'Country was successfully created.'
        format.html { redirect_to(countries_url) }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        flash[:notice] = 'Country was successfully updated.'
        format.html { redirect_to(countries_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to(countries_url) }
      format.xml  { head :ok }
    end
  end
end