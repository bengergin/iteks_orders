class SampleStatusesController < ApplicationController
  before_filter :find_sample
  
  def index
    @statuses = @sample.sample_statuses
  end
  
  def new
    @status = @sample.sample_statuses.new
  end
  
  def create

    @status = case params[:type]
      when "SampleSent" then @sample.sample_sents.create(params[:sample_status].merge(:created_by => @current_user.id, :updated_by => @current_user.id))
      when "SampleReceived" then @sample.sample_receiveds.create(params[:sample_status].merge(:created_by => @current_user.id, :updated_by => @current_user.id))
      when "SampleRejected" then @sample.sample_rejecteds.create(params[:sample_status].merge(:created_by => @current_user.id, :updated_by => @current_user.id))
      when "SampleApproved" then @sample.sample_approveds.create(params[:sample_status].merge(:created_by => @current_user.id, :updated_by => @current_user.id))
      when "SampleCompleted" then @sample.sample_completeds.create(params[:sample_status].merge(:created_by => @current_user.id, :updated_by => @current_user.id))
      when "SamplePrice" then @sample.sample_prices.create(params[:sample_status].merge(:created_by => @current_user.id, :updated_by => @current_user.id))  
      when "SampleComment" then @sample.sample_comments.create(params[:sample_status].merge( :created_by => @current_user.id, :updated_by => @current_user.id))      
    end
    if @status
      flash[:notice] = "Status successfully added."
      redirect_to sample_path(@sample)
    else
      render :action => "new"
    end
  end
  
  private
  def find_sample
    @sample = Sample.find(params[:sample_id])
  end
end
