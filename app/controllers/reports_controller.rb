class ReportsController < ApplicationController
  before_filter :can_read_reports
  before_filter :can_write_reports, :only => %{new edit create update}
  before_filter :can_destroy_reports, :only => :destroy
  
  def index
    respond_to do |format|
      format.html
    end
  end
  
  def customer_financials
    if @current_user.admin?
      @customer_list = Customer.find(:all, :order => "name")
      respond_to do |format|
        format.pdf do
          @header = "Iteks Tekstil Ltd - Customer Financials - #{Time.now.to_s(:day_month_year)}"
          render :pdf => @current_user
        end
      end
    end
  end
  
  def total_current_order_financials
    if @current_user.admin?
    @dispatches = Dispatch.scoped(:conditions => {:completed_on => nil})
    
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tesktil Ltd - Order Financials - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
    
    end
  end
   
  def profit_percents_2013
    if @current_user.admin?
    @dispatches = Dispatch.scoped(:conditions => {:completed_on => nil})
    
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Order Financials - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
    
    end
  end
  
  def no_buy_sell
    @dispatches = Dispatch.scoped(:select => "DISTINCT(order_id), packs_red_sealed, total_number_of_packs, customer_name", :conditions => {:completed_on => nil})
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - No Buying/Selling - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
  
  def country_financials
    if @current_user.admin?
    	respond_to do |format|
      	format.pdf do
        	@header = "Iteks Tekstil Ltd - Country Financials - #{Time.now.to_s(:day_month_year)}"
        	render :pdf => @current_user
      end
    end
    end
  end
  
  def factory_financials
    if @current_user.admin?
    
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Factory Financials - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
    
    end
  end
  
  def unplaced_orders_turkey
    @country_dispatches = Dispatch.scoped(:select => "DISTINCT order_id", :conditions => {:country_name => "Turkey", :factory_name => nil, :completed_on => nil})
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Unplaced Orders Report - Turkey - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
  
  def unplaced_orders_china
    @country_dispatches = Dispatch.scoped(:select => "DISTINCT order_id", :conditions => {:country_name => "China", :factory_name => nil, :completed_on => nil})
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Unplaced Orders Report - China - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
  
  def unplaced_orders_india
    @country_dispatches = Dispatch.scoped(:select => "DISTINCT order_id", :conditions => {:country_name => "India", :factory_name => nil, :completed_on => nil})
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Unplaced Orders Report - India - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
  
  def customer_orders
    @customer_list = Customer.find(:all, :conditions => {:deleted => 0}, :order => "name")
    
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Customer Orders Report - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
  
  def late_orders_turkey
    @all_country_dispatches = ActiveRecord::Base.connection_pool.with_connection do |c| 
      c.select_all('SELECT * FROM dispatches d WHERE d.completed_on IS NULL AND d.country_name = "Turkey" ORDER BY ex_factory_date')
    end
    
    @orders = {}
    @all_country_dispatches.each do |dispatch|
      if @orders.has_key?(dispatch['order_id'])
        @orders[dispatch['order_id']] = dispatch if @orders[dispatch['order_id']]['ex_factory_date'].to_date > dispatch['ex_factory_date'].to_date
      else
        @orders[dispatch['order_id']] = dispatch
      end
    end
    
    @country_dispatches = @orders.values.sort_by { |o| o['ex_factory_date'].to_date }
    
    respond_to do |format|
      format.pdf do
        @header = "Iteks Tekstil Ltd - Late Orders Report - Turkey - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
  
  def late_orders_china
    @all_country_dispatches = ActiveRecord::Base.connection_pool.with_connection do |c| 
      c.select_all('SELECT * FROM dispatches d WHERE d.completed_on IS NULL AND d.country_name = "China" ORDER BY ex_factory_date')
    end
    
    @orders = {}
    @all_country_dispatches.each do |dispatch|
      if @orders.has_key?(dispatch['order_id'])
        @orders[dispatch['order_id']] = dispatch if @orders[dispatch['order_id']]['ex_factory_date'].to_date > dispatch['ex_factory_date'].to_date
      else
        @orders[dispatch['order_id']] = dispatch
      end
    end
    
    @country_dispatches = @orders.values.sort_by { |o| o['ex_factory_date'].to_date }
    
    respond_to do |format|
      format.csv
      
      format.pdf do
        @header = "Iteks Tekstil Ltd - Late Orders Report - China - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @current_user
      end
    end
  end
end
