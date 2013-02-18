class PeopleController < ApplicationController
  before_filter :can_read_people
  before_filter :can_destroy_people,      :only => %w{destroy}
  before_filter :can_write_people,        :only => %w{new edit create update}
  
  # Index Options
  def index
    @people = Person.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  def new
    @person = Person.new
    render :action => "edit"
  end
  
  # Create Options
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(people_url) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Edit Options
  def edit
    @person = Person.find(params[:id])
  end
  
  # Update Options
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to(people_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Destroy Options
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
  
  def show
    @person = Person.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf
    end
  end
  
  def load_people
    @people = Person.find(:all, :order => "last_name")
  end
end
