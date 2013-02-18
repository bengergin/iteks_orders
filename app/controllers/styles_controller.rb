class StylesController < ApplicationController
  before_filter :admin_required
  before_filter :load_style_associations, :only => %w{new edit create update amend}
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @styles = Style.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @styles }
    end
  end

  # New Options
  def new
    @style = Style.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @style = Style.find(params[:id])
    @departments = Department.find(:all)
  end

  # Create Options
  def create
    @style = Style.new(params[:style])

    respond_to do |format|
      if @style.save
        flash[:notice] = 'Style was successfully created.'
        format.html { redirect_to(styles_url) }
        format.xml  { render :xml => @style, :status => :created, :location => @style }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @style = Style.find(params[:id])

    respond_to do |format|
      if @style.update_attributes(params[:style])
        flash[:notice] = 'Style was successfully updated.'
        format.html { redirect_to(styles_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @style = Style.find(params[:id])
    @style.destroy

    respond_to do |format|
      format.html { redirect_to(styles_url) }
      format.xml  { head :ok }
    end
  end
  
  # Load Associations
  def load_style_associations
    @products = Product.find(:all, :order => 'name')
  end
end
