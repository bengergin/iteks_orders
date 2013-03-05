class OrdersController < ApplicationController
  before_filter :can_read_orders,         :except => %w{options}
  before_filter :can_destroy_orders,      :only => %w{destroy}
  before_filter :can_write_orders,        :only => %w{new edit create update 
                                                      dispatches}
                                                      
  before_filter :load_order_associations, :only => %w{new edit create update repeat
                                                      dispatches new_dispatch update_dispatches 
                                                      additional_info update_additional_info 
                                                      packaging update_packaging
                                                      new_pack }
                                                      
  before_filter :find_order,              :only => %w{attach contract repeat edit 
                                                      update dispatches 
                                                      update_additional_info additional_info 
                                                      update_packaging packaging
                                                      update_attachments
                                                      update_contracts}

  skip_before_filter :login_required, :verify_authenticity_token, 
                     :only => :options
  
  def index
    @customers  = Customer.all(:order => "name")
    @countries  = Country.all(:order => "name")
    @products   = Product.find(:all, :order => 'name')
    @dispatches = @current_user.dispatches.is_complete(params[:complete]).placed_in(params[:country_ids], params[:unplaced]).for(params[:customer_ids]).for_department(params[:department_ids]).is_product(params[:product_ids]).by(params[:company_ids]).has(params[:buying_price])
    
    respond_to do |format|
      format.html
      format.csv { headers["Content-Disposition"] = "attachment" }
      format.pdf do
        @dispatches = @dispatches.all(:order => :ex_factory_date)
        @orientation = :landscape
        @header = "Iteks Tekstil Ltd - Orders Report - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @dispatches
      end
    end
  end
  
  def options
    head :method_not_allowed
  end
  
  def attach
  end
  
  def contract
  end
  
  def new
    @order = Order.new_with_packs(:user_id => @current_user.id)
    @size_charts = []
    @weight_sizes = @departments.first.sizes
  end
  
  def additional_info
  end
  
  def packaging
  end
  
  def dispatches
    dispatch = @order.dispatches.build(:number => 1) if @order.dispatches.empty?

    @order.dispatches.each do |dispatch|
      @order.pack_sizes.each do |pack_size|
        dispatch.dispatch_quantities.build(:pack_size_id => pack_size.id) unless dispatch.dispatch_quantities.detect { |d| d.pack_size_id == pack_size.id }
      end
    end
  end
  
def repeat
    @order = @order.clone  
    @order.barcode_number = nil
    @order.style_number = nil
    @order.line_number = nil
    @order.factory_id = nil
    @order.qc= nil
    @order.red_seal_received_by = nil
    @order.red_seal_received_on = nil
    @order.red_seal_approved_by = nil
    @order.red_seal_approved_by = nil
    @order.gold_seal_received_by = nil
    @order.gold_seal_received_on = nil
    @order.gold_seal_approved_by = nil
    @order.gold_seal_approved_by = nil
    @order.testing_completed_on = nil
    @order.testing_completed_by = nil
    @order.bulk_yarn_ordered_on = nil
    @order.bulk_yarn_ordered_by = nil
    @order.fibre_composition_received_on = nil
    @order.fibre_composition_received_by = nil
    @order.packaging_proof_sent_on = nil
    @order.packaging_proof_sent_by = nil
    @order.packaging_approved_on = nil
    @order.packaging_approved_by = nil
    @order.bulk_yarn_arrived_on = nil
    @order.bulk_yarn_arrived_by = nil
    @order.knitting_started_on = nil
    @order.knitting_started_by = nil
    @order.placed_on = nil
    @order.placed_by = nil
    @order.created_at = nil
    @order.order_emailed = nil
    @order.packs.each do |pack|
      pack.saved_exchange_rate = nil
      pack.gross_price_gbp = nil
      pack.gross_price_eur = nil
      pack.gross_price_usd = nil
      pack.red_seal_approved_on = nil
      pack.gold_seal_approved_on = nil
      pack.fibre_composition_received_on = nil
      pack.testing_completed_on = nil
      pack.buying_price = nil
      pack.pack_sizes.each do |pack_size|
      pack_size.barcode_number = nil
      pack_size.style_number = nil
      pack_size.line_number = nil
    @order.save
      end
    end
    
    render :action => 'new'
  end
  
  def show
    @factories = Factory.find_all_by_country_name(Country::NAMES.first)
    @order = @current_user.orders.find(params[:id])
    @metastatus = Metastatus.new(:order_id => @order.id, :user_id => @current_user.id)
    respond_to do |format|
      format.html
      format.xml { render :xml => @order }
      format.pdf do
        @header = "Iteks Tekstil Ltd - Factory Order Form - #{@order.reference} - #{Time.now.to_s(:day_month_year)}"
        render :pdf => @order
      end
    end
  end
  
  def metastatus
    @order = @current_user.orders.find(params[:id])
    params[:date] = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    @metastatus = Metastatus.new(params[:metastatus].merge(params[:field_name].intern => params[:date], :order_id => @order.id, :user_id => @current_user.id))
    @metastatus.save
    redirect_to order_path(@order)
  end
  
  def create
    @order = Order.new_with_packs(params[:order])
    if @order.save
      flash[:notice] = "Successfully created order and packs."
      redirect_to additional_info_order_path(@order)
    else
      @size_charts = SizeChart.specifications.find_all_by_customer_id_and_department_id(@order.customer_id, @order.department_id)
      @weight_sizes = @order.department.sizes
      render :action => 'new'
    end
  end
  
  def edit
    render :action => 'new'
  end
  
  def update
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully updated order and packs."
      redirect_to additional_info_order_path(@order)
    else
      render :action => 'new'
    end
  end
  
  def update_additional_info
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully updated packs."
      redirect_to packaging_order_path(@order)
    else
      redirect_to packaging_order_path(@order)    	
    end
  end
  
  def update_packaging
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully packaging info."
      redirect_to dispatches_order_path(@order)
    else
      redirect_to dispatches_order_path(@order)    	
    end
  end
  
  def update_dispatches
  	@order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully added dispatches."
      if @order.order_emailed != true
  			if @order.country_id == 73667960  
      		OrderMailer.deliver_turkey(@order) unless @order.company_id == 563640997
      	else
      		OrderMailer.deliver_elsewhere(@order) unless @order.company_id == 563640997
      	end
      	@order.update_attribute(:order_emailed, true)
      end
      redirect_to order_path(@order)
    else
      @order.dispatches.each do |dispatch|
        if dispatch.new_record?
          @order.pack_sizes.each {|pack_size| dispatch.dispatch_quantities.build(:pack_size_id => pack_size.id) unless dispatch.dispatch_quantities.detect { |d| d.pack_size_id == pack_size.id } }
        end
      end
      render :action => 'dispatches'
    end
  end
  
  def update_attachments
    if @order.update_attributes(params[:order])
      flash[:notice] = "Attachment successfully added."
    end
    redirect_to attach_order_path(@order)
  end  
  
  def update_contracts
    if @order.update_attributes(params[:order])
      flash[:notice] = "Contract successfully added."
    end
    redirect_to contract_order_path(@order)
  end
  
  # AJAX actions.
  def new_pack
    render :partial => "pack", :object => Pack.new_with_add_on(:letter => params[:id])
  end
  
  def new_dispatch
    @order = @current_user.orders.find(params[:id])
    dispatch = Dispatch.new(:number => params[:next_number].succ)
    @order.pack_sizes.each {|pack_size| dispatch.dispatch_quantities.build(:pack_size_id => pack_size.id, :quantity => 0) }
    render :partial => "dispatch", :object => dispatch
  end
  
  def new_pack_size
    render :partial => "pack_size", 
           :object => PackSize.new(:size => Size.find(params[:size_id])), 
           :locals => { :pack => Pack.new(:letter => params[:pack_letter]),
                        :per_order => (params[:per_pack] == "false") }
  end
  
  def new_pack_add_on
    pack_add_on = PackAddOn.new
    pack_add_on.build_add_on
    render :partial => 'pack_add_on',
           :object => pack_add_on,
           :locals => { :pack => Pack.new(:letter => params[:pack_letter])}
  end
  
  def search
    ids = Dispatch.find_id_by_solr(params[:query], :limit => 1000).docs
    @dispatches = @current_user.dispatches.find(:all, :conditions => ["id IN (?)", ids])
  rescue
    @dispatches = []
  end
  
  protected
  
  def find_order
    @order        = @current_user.orders.find(params[:id])
    @size_charts  = SizeChart.specifications.find_all_by_customer_id_and_department_id(@order.customer_id, @order.department_id) | [@order.size_chart].compact
    @weight_sizes = Size.find_all_by_department_id(@order.department_id)
  end
  
  def load_order_associations
    @transports              	= Transport.find(:all, :order => 'name')
    @warehouses              	= Warehouse.find(:all, :order => 'name')
    @styles                  	= Style.find(:all, :order => 'name')
    @customers               	= Customer.find(:all, :order => 'name')
    @departments             	= Department.find(:all, :order => 'name')
    @sizes                   	= Size.find(:all, :order => 'department_id, subscript')
    @box_end_label_positions 	= BoxEndLabelPosition.find(:all)
    @wash_care_symbols       	= WashCareSymbol.find(:all, :order => 'filename')
    @designs                 	= Design.find(:all, :order => 'reference')
    @packagings              	= Packaging.all
    @warehouses              	= Warehouse.all
    @testings             		= Testing.find(:all, :order => 'id')
  end
end
