class DesignsController < ApplicationController
  before_filter :can_read_designs
  before_filter :can_destroy_designs,      :only => %w{destroy}
  before_filter :can_write_designs,        :only => %w{new edit create update amend}
  
  before_filter :load_design_associations, :only => %w{new edit create update amend}
  before_filter :load_design, :only => %w{show edit update attach amend}
    
  def index
    respond_to do |format|
      format.html do
        if @current_user.is_customer?
          @designs = @current_user.customer_designs.paginate(:page => params[:page], :order => 'created_at DESC')
        else
          @designs = Design.paginate(:page => params[:page], :order => 'created_at DESC' )
        end
      end
      format.js do
        @designs = Design.find(:all, :select => "id, reference", :conditions => ['reference LIKE ?', "%#{params[:val]}%"], :order => "reference", :limit => 20)
      end
    end
  end
  
  def attach
    @design = Design.find(params[:id])
  end
  
  def show
    if @design
      render :partial => "thumbnail", :object => @design if request.xhr?
    else
      render :text => ""
    end
  end
  
  def new
    @design = Design.new
    render :action => "edit"
  end
  
  def amend
    @design = Design.find(params[:id]).clone
    render :action => "edit"
  end
  
  def destroy
    Design.find(params[:id]).destroy
    flash[:notice] = "Design deleted successfully."
    redirect_to designs_path
  end
  
  def create
    @design = @current_user.designs.new(params[:design])
    if @design.save
      flash[:notice] = "Your reference number is #{@design.reference}. Please attach any images below."
      redirect_to attach_design_path(@design)
    else
      render :action => "edit"
    end
  end
  
  def update
    @updated = @design.update_attributes(params[:design].merge(:updated_by => @current_user.id))
    if params[:attach]
      if @updated
        flash[:notice] = "Attachment successfully added."
        redirect_to attach_design_path(@design)
      else
        render :action => "attach"
      end
    else
      redirect_to attach_design_path
    end
  end
  
  def search
    ids = Design.find_id_by_solr(params[:query], :limit => 100000).docs
    if @current_user.is_customer?
      @designs = @current_user.customer_designs.paginate(:page => params[:page], :order => 'created_at DESC', :conditions => ["id IN (?)", ids])
    else
      @designs = Design.paginate(:page => params[:page], :order => 'created_at DESC', :conditions => ["id IN (?)", ids])
    end
  rescue
    @designs = []
  end
  
  def cloud
    @tags = Tag.counts(:order => "count DESC, name",
      :limit => 100).sort_by { |tag| tag.name.downcase }
  end
  
  def load_design_associations
    @styles = Style.find(:all, :order => 'name')
    @customers = Customer.find(:all, :order => 'name')
    @departments = Department.find(:all, :order => 'name')
  end
  
  def load_design
    @design = if params[:reference]
      if @current_user.is_customer?
        @current_user.customer_designs.find_by_reference(params[:reference])
      else
        Design.find_by_reference(params[:reference])  
      end
    else
      if @current_user.is_customer?
        @current_user.customer_designs.find(params[:id])
      else
        Design.find(params[:id])
      end
    end
  end
end
