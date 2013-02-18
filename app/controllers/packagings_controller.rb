class PackagingsController < ApplicationController
  before_filter :can_read_packagings
  before_filter :can_destroy_packagings,      :only => %w{destroy}
  before_filter :can_write_packagings,        :only => %w{new edit create update amend}
  
  before_filter :load_packaging_associations, :only => %w{new edit create update amend}
  before_filter :load_packaging,              :only => %w{show edit update attach amend}
  
  def index
    respond_to do |format|
      format.html do
        @packagings = Packaging.paginate(:page => params[:page], :order => 'created_at DESC')
      end
      format.js do
        @packagings = Packaging.find(:all, :select => "id, reference", :conditions => ['reference LIKE ?', "%#{params[:val]}%"], :order => "reference", :limit => 20)
      end
    end
  end
  
  def attach
    @packaging = Packaging.find(params[:id])
  end
  
  def show
    if @packaging
      render :partial => "thumbnail", :object => @packaging if request.xhr?
    else
      render :text => ""
    end
  end
  
  def new
    @packaging = Packaging.new
    render :action => "edit"
  end
  
  def destroy
    Packaging.find(params[:id]).destroy
    flash[:notice] = "Packaging deleted successfully."
    redirect_to packagings_path
  end
  
  def amend
    @packaging = Packaging.find(params[:id]).clone
    render :action => "edit"
  end
  
  def create
    @packaging = @current_user.packagings.new(params[:packaging])
    if @packaging.save
      flash[:notice] = "Your reference number is #{@packaging.reference}. Please attach any images below."
      redirect_to attach_packaging_path(@packaging)
    else
      render :action => "edit"
    end
  end
  
  def update
    @updated = @packaging.update_attributes(params[:packaging].merge(:updated_by => @current_user.id))
    if params[:attach]
      if @updated
        flash[:notice] = "Attachment successfully added."
        redirect_to attach_packaging_path(@packaging)
      else
        render :action => "attach"
      end
    else
      redirect_to attach_packaging_path
    end
  end
  
  def search
    @search = Packaging.find_by_solr(params[:query], :limit => 1000)
    @packagings = @search.records
  rescue
    @packagings = []
  end
  
  def load_packaging_associations
    @styles = Style.find(:all, :order => 'name')
    @customers = Customer.find(:all, :order => 'name')
    @departments = Department.find(:all, :order => 'name')
  end
  
  def load_packaging
    @packaging = if params[:reference]
      Packaging.find_by_reference(params[:reference])
    else
      Packaging.find(params[:id])
    end
  end
  
  def load_packagings
    @packagings = Packaging.paginate(:page => params[:page], :order => 'created_at DESC')
  end
end
