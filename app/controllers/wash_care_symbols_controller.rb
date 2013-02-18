class WashCareSymbolsController < ApplicationController
  before_filter :admin_required
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @wash_care_symbols = WashCareSymbol.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wash_care_symbols }
    end
  end

  # New Options
  def new
    @wash_care_symbol = WashCareSymbol.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @wash_care_symbol = WashCareSymbol.find(params[:id])
    @departments = Department.find(:all)
  end

  # Create Options
  def create
    @wash_care_symbol = WashCareSymbol.new(params[:wash_care_symbol])

    respond_to do |format|
      if @wash_care_symbol.save
        flash[:notice] = 'WashCareSymbol was successfully created.'
        format.html { redirect_to(wash_care_symbols_url) }
        format.xml  { render :xml => @wash_care_symbol, :status => :created, :location => @wash_care_symbol }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wash_care_symbol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @wash_care_symbol = WashCareSymbol.find(params[:id])

    respond_to do |format|
      if @wash_care_symbol.update_attributes(params[:wash_care_symbol])
        flash[:notice] = 'WashCareSymbol was successfully updated.'
        format.html { redirect_to(wash_care_symbols_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wash_care_symbol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @wash_care_symbol = WashCareSymbol.find(params[:id])
    @wash_care_symbol.destroy

    respond_to do |format|
      format.html { redirect_to(wash_care_symbols_url) }
      format.xml  { head :ok }
    end
  end
end