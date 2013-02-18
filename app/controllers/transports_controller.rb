class TransportsController < ApplicationController
  before_filter :admin_required  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @transports = Transport.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transports }
    end
  end

  # New Options
  def new
    @transport = Transport.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @transport = Transport.find(params[:id])
    @departments = Department.find(:all)
  end

  # Create Options
  def create
    @transport = Transport.new(params[:transport])

    respond_to do |format|
      if @transport.save
        flash[:notice] = 'Transport was successfully created.'
        format.html { redirect_to(transports_url) }
        format.xml  { render :xml => @transport, :status => :created, :location => @transport }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @transport = Transport.find(params[:id])

    respond_to do |format|
      if @transport.update_attributes(params[:transport])
        flash[:notice] = 'Transport was successfully updated.'
        format.html { redirect_to(transports_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @transport = Transport.find(params[:id])
    @transport.destroy

    respond_to do |format|
      format.html { redirect_to(transports_url) }
      format.xml  { head :ok }
    end
  end
end