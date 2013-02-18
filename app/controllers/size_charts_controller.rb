class SizeChartsController < ApplicationController
  before_filter :can_read_size_charts
  before_filter :can_destroy_size_charts,      :only => %w{destroy}
  before_filter :can_write_size_charts,        :only => %w{new edit create update}
  
  before_filter :load_size_chart_associations, :only => [:new, :edit, :create, :repeat]
   
  def index
    @customers  = Customer.all(:order => "name")
    @countries  = Country.all(:order => "name")
    @size_charts = @current_user.size_charts.for(params[:customer_ids]).for_department(params[:department_ids])
    
    respond_to do |format|
      format.html
      format.csv
      format.js do
        @size_charts = @size_charts.scoped(:conditions => { :department_id => params[:department_id] }) unless params[:department_id].blank?
        @size_charts = @size_charts.scoped(:conditions => { :customer_id => params[:customer_id] }) unless params[:customer_id].blank?
      end
    end
  end
  
  def new
    @size_chart = SizeChart.new(:specification => true)
    @size_chart.build_size_chart_diagram
    @size_chart.measurements.build(:number => 1)
    render :action => 'edit'
  end
  
  def create
    @size_chart = SizeChart.new(params[:size_chart])
    if @size_chart.save
      SizeMailer.deliver_caroline(@size_chart)
      flash[:notice] = "Successfully created size chart and measurements."
      redirect_to size_chart_path(@size_chart)
    else
      @size_chart.build_size_chart_diagram
      render :action => 'edit'
    end
  end
  
  def show
    @size_chart = SizeChart.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @size_chart }
      format.pdf
    end
  end
  
  def edit
   @size_chart = SizeChart.find(params[:id])

   
    @size_chart.build_size_chart_diagram
    render :action => 'edit'
 
  end
  
  def update
    @size_chart = SizeChart.find(params[:id])
    if @size_chart.update_attributes(params[:size_chart])
      flash[:notice] = "Successfully updated size chart and measurements."
      redirect_to size_chart_path(@size_chart)
    else
      render :action => 'edit'
    end
  end
  
  def repeat
    @size_chart = SizeChart.find(params[:id]) 
    @size_chart = @size_chart.clone
    @size_chart.created_at = nil
    @size_chart.update_attribute(:specification, true) 
     SizeMailer.deliver_caroline(@size_chart)
    render :action => 'edit'
  end
  
  def new_measurement
    measurement = Measurement.new(:number => params[:number])
    params[:sizes] && params[:sizes].each do |size_id|
      measurement.measurement_sizes.build(:size_id => size_id)
    end
    render :partial => 'measurement', :object => measurement
  end
  
  def new_measurement_size
    render :partial => 'measurement_size', 
           :object => MeasurementSize.new(:size_id => params[:size_id]), 
           :locals => { :measurement => Measurement.new(:number => 0) }
  end
  
  protected
  
  def load_size_chart_associations
    @customers = Customer.find(:all, :order => "name")
    @departments = Department.find(:all, :order => "name")
    @sizes = Size.find(:all, :order => 'department_id, subscript')
  end
end
