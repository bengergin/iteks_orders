class ExchangeRatesController < ApplicationController
  before_filter :admin_required
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @exchange_rates = ExchangeRate.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exchange_rates }
    end
  end

  # New Options
  def new
    @exchange_rate = ExchangeRate.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @exchange_rate = ExchangeRate.find(params[:id])
  end

  # Create Options
  def create
    @exchange_rate = ExchangeRate.new(params[:exchange_rate])

    respond_to do |format|
      if @exchange_rate.save
        flash[:notice] = 'ExchangeRate was successfully created.'
        format.html { redirect_to(exchange_rates_url) }
        format.xml  { render :xml => @exchange_rate, :status => :created, :location => @exchange_rate }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exchange_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @exchange_rate = ExchangeRate.find(params[:id])

    respond_to do |format|
      if @exchange_rate.update_attributes(params[:exchange_rate])
        flash[:notice] = 'ExchangeRate was successfully updated.'
        format.html { redirect_to(exchange_rates_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exchange_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @exchange_rate = ExchangeRate.find(params[:id])
    @exchange_rate.destroy

    respond_to do |format|
      format.html { redirect_to(exchange_rates_url) }
      format.xml  { head :ok }
    end
  end
end