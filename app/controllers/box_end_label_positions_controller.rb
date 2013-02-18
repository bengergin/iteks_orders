class BoxEndLabelPositionsController < ApplicationController
  before_filter :admin_required
  
  # Choose the layout
  layout "admin"
  
  # Index Options
  def index
    @box_end_label_positions = BoxEndLabelPosition.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @box_end_label_positions }
    end
  end

  # New Options
  def new
    @box_end_label_position = BoxEndLabelPosition.new
    render :action => "edit"
  end

  # Edit Options
  def edit
    @box_end_label_position = BoxEndLabelPosition.find(params[:id])
  end

  # Create Options
  def create
    @box_end_label_position = BoxEndLabelPosition.new(params[:box_end_label_position])

    respond_to do |format|
      if @box_end_label_position.save
        flash[:notice] = 'BoxEndLabelPosition was successfully created.'
        format.html { redirect_to(box_end_label_positions_url) }
        format.xml  { render :xml => @box_end_label_position, :status => :created, :location => @box_end_label_position }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @box_end_label_position.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update Options
  def update
    @box_end_label_position = BoxEndLabelPosition.find(params[:id])

    respond_to do |format|
      if @box_end_label_position.update_attributes(params[:box_end_label_position])
        flash[:notice] = 'BoxEndLabelPosition was successfully updated.'
        format.html { redirect_to(box_end_label_positions_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @box_end_label_position.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @box_end_label_position = BoxEndLabelPosition.find(params[:id])
    @box_end_label_position.destroy

    respond_to do |format|
      format.html { redirect_to(box_end_label_positions_url) }
      format.xml  { head :ok }
    end
  end
end