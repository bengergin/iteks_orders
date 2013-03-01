class SamplesController < ApplicationController
  before_filter :can_read_samples
  before_filter :can_destroy_samples,      :only => %w{destroy}
  before_filter :can_write_samples,        :only => %w{new edit create update repeat}
                                                      
  before_filter :load_sample_associations, :only => %w{new edit create update repeat}
                                                      
  before_filter :find_sample, :only => [:edit, :update, :show, :repeat]
  before_filter :new_sample, :only => [:new, :create]
  before_filter :set_creator, :only => :create
  before_filter :set_updater, :only => [:create, :update]
  
  def attach
    @sample = Sample.find(params[:id])
  end
  
  def index
    @customers  = Customer.all(:order => "name")
    @countries  = Country.all(:order => "name")
    @samples = @current_user.samples.is_complete(params[:complete]).placed_in(params[:country_ids], params[:unplaced]).for(params[:customer_ids]).for_department(params[:department_ids]).by(params[:company_ids])
    
    respond_to do |format|
      format.html
      format.csv { headers["Content-Disposition"] = "attachment" }
    end
  end

  def create
    if @sample.save
      SampleMailer.deliver_mail(@sample)
    end
    flash[:notice] = "Successfully created a new sample."
    redirect_to attach_sample_path(@sample)
    else
      render :action => 'edit'
    
  end
  
  def edit
    if @sample.sample_add_ons.empty?
      @sample.sample_add_ons.build
      @sample.sample_add_ons.first.build_add_on
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.pdf
    end
  end
  
  def edit
    render :action => "edit"
  end
  
  def new 
    @sample.sample_add_ons.build
    @sample.sample_add_ons.first.build_add_on
    render :action => "edit"
  end
  
  def new_sample_add_on
    sample_add_on = SampleAddOn.new
    sample_add_on.build_add_on
    render :partial => 'sample_add_on',
           :object => sample_add_on,
           :locals => { :sample => Sample.new }
  end
  
  def search
    ids = Sample.find_id_by_solr(params[:query], :limit => 5000).docs
    @samples = @current_user.samples.find(:all, :conditions => ["id IN (?)", ids])
  rescue
    @samples = []
  end
  
  def update
    @updated = @sample.update_attributes(params[:sample].reverse_merge("size_ids" => []))
    if params[:attach]
      if @updated
        flash[:notice] = "Attachment successfully added."
        redirect_to attach_sample_path(@sample)
      else
        render :action => "attach"
      end
    else
      redirect_to attach_sample_path(@sample)
    end
  end
  
  def repeat
    @sample = Sample.find(params[:id]).clone
    @sample.sample_add_ons.build
    @sample.sample_add_ons.first.build_add_on
    @size_charts = SizeChart.specifications.find_all_by_customer_id_and_department_id(@sample.customer_id, @sample.department_id)
    render :action => 'edit'
  end
  
  def load_sample_associations
    @styles = Style.find(:all, :order => 'name')
    @customers = Customer.find(:all, :order => 'name')
    @departments = Department.find(:all, :order => 'name')
    @sizes = Size.find(:all, :order => 'department_id, subscript')
    @designs = Design.find(:all, :order => 'reference')
    @countries = Country.find(:all)
    @factories = Factory.find_all_by_country_id(@countries.first.id)
    @size_charts = SizeChart.specifications.find_all_by_customer_id_and_department_id(@customers.first.id, @departments.first.id)
  end
  
  def find_sample
    @sample = Sample.find(params[:id])
    @size_charts = SizeChart.specifications.find_all_by_customer_id_and_department_id(@sample.customer_id, @sample.department_id) | [@sample.size_chart].compact
    @factories = Factory.find_all_by_country_id(@sample.country_id)
  end
  
  def new_sample
    @sample = Sample.new(params[:sample])
  end
  
  def set_creator
    @sample.created_by = @current_user.id
  end
  
  def set_updater
    @sample.updated_by = @current_user.id
  end
end
