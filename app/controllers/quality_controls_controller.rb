class QualityControlsController < ApplicationController
  before_filter :can_read_quality_controls
  before_filter :can_write_quality_controls, :only => %{new edit create update}
  before_filter :can_destroy_quality_controls, :only => :destroy
    
  # Index Options
  def index
    @quality_controls = @current_user.quality_controls.for(params[:customer_ids]).for_department(params[:department_ids])
    
    respond_to do |format|
      format.html
      format.csv
      format.js do
        @quality_controls = @quality_controls.scoped(:conditions => { :department_id => params[:department_id] }) unless params[:department_id].blank?
        @quality_controls = @quality_controls.scoped(:conditions => { :customer_id => params[:customer_id] }) unless params[:customer_id].blank?
      end
    end
  end

  # New Options
  def new
    @quality_control = QualityControl.new(:user_id => @current_user.id)
    render :action => "edit"
  end

  # Edit Options
  def edit
    @quality_control = QualityControl.find(params[:id])
    @orders = Order.find(:all)
  end

  # Create Options
  def create
    @quality_control = QualityControl.new(params[:quality_control])

    respond_to do |format|
      if @quality_control.save
        flash[:notice] = 'Quality Control was successfully created.'
        format.html { redirect_to attach_quality_control_path(@quality_control) }
        format.xml  { render :xml => @quality_control, :status => :created, :location => @quality_control }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quality_control.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def attach
    @quality_control = QualityControl.find(params[:id])
  end
  
  def send_email_and_redirect_to_show
    @quality_control = QualityControl.find(params[:id])
    if !@quality_control.email_sent? 
    	QualityControlMailer.deliver_report(@quality_control)
    	@quality_control.update_attribute(:email_sent, true)
    end
    redirect_to quality_control_path(@quality_control)
	end

  # Update Options
  def update
    @quality_control = QualityControl.find(params[:id])
    @updated = @quality_control.update_attributes(params[:quality_control])
    if params[:attach]
      if @updated
        flash[:notice] = "Attachment successfully added."
        redirect_to attach_quality_control_path(@quality_control)
      else
        render :action => "attach"
      end
    else
      redirect_to attach_quality_control_path(@quality_control)
    end
  end
  
  # Show Options
  def show
    @quality_control = QualityControl.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @quality_control }
      format.pdf do
        @header = "Fimex Ltd - Quality Control Report - #{@quality_control.id} - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @quality_control
      end
    end
  end

  # Destroy Options
  def destroy
    @quality_control = QualityControl.find(params[:id])
    @quality_control.destroy

    respond_to do |format|
      format.html { redirect_to(quality_controls_url) }
      format.xml  { head :ok }
    end
  end
end
