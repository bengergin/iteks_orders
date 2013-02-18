class CompaniesController < ApplicationController
  before_filter :admin_required
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @companies = Company.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # New Options
  def new
    @company = Company.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @company = Company.find(params[:id])
  end

  # Create Options
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        flash[:notice] = 'Company was successfully created.'
        format.html { redirect_to(companies_url) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to(companies_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
