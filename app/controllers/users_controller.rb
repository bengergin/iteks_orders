class UsersController < ApplicationController
  before_filter :admin_required
  
  before_filter :load_levels,
                :load_customers,
                :load_countries,
                :load_companies,
                :load_departments,
                :only => %w{new edit update create}
                
  layout "admin"
  
  def new
    @user = User.new
    render :action => "edit"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      expire_page formatted_users_path(:pdf)
      flash[:notice] = "Successfully created a new user."
      redirect_to users_path
    else
      render :action => "edit"
    end
  end
  
  def index
    @users = User.all(:order => "last_name", :conditions => {:deleted => 0})
    respond_to do |format|
      format.html
      format.csv { headers["Content-Disposition"] = "attachment"; render :layout => false }
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id], :order => 'first_name')
    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to users_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end
  
  private
  
  def load_levels
    @levels = [
      ["No access",             0],
      ["Read-only",             1],
      ["Read & Write",          2],
      ["Read, Write & Destroy", 3]
    ]
  end
  
  def load_customers
    @customers = Customer.all(:order => "name")
  end
  
  def load_countries
    @countries = Country.all(:order => "name")
  end
  
  def load_companies
    @companies = Company.all(:order => "name")
  end
  
  def load_departments
    @departments = Department.all(:order => "name")
  end
end
