ActionController::Routing::Routes.draw do |map|
  
  map.logout '/logout', :controller => "sessions", :action => "destroy"
  
  map.resource :session
  map.resources :roles
  map.resources :people
  map.resources :warehouses
  map.resources :wash_care_symbols
  map.resources :box_end_label_positions
  map.resources :users
  map.resources :transports
  map.resources :companies
  map.resources :styles
  map.resources :sizes
  map.resources :customers
  map.resources :departments
  map.resources :factories
  map.resources :countries
  map.resources :attachments
  map.resources :contracts    
  map.resources :products
  map.resources :exchange_rates
  map.resources :testings
  
  map.resources :reports, :collection => { :unplaced_orders_turkey => :get,
                                           :unplaced_orders_china => :get,
                                           :unplaced_orders_india => :get,
                                           :late_orders_turkey => :get,
                                           :late_orders_china => :get,
                                           :total_current_order_financials => :get,
                                           :customer_profit => :get,
                                           :profit_percents_2013 => :get,
                                           :country_financials => :get,
                                           :customer_financials => :get,
                                           :factory_financials => :get,
                                           :no_buy_sell => :get,
                                           :customer_orders => :get }  
    
  map.resources :quality_controls,
                :has_many   => :uploaded_files, 
                :member     => { 
                									:attach => :get, :amend => :get,
                									:send_email_and_redirect_to_show => :get	
                								}
  
  # Allow designs to be accessed by reference alone; e.g. /designs/DR-001
  map.with_options :controller => "designs", :action => "show", :reference => /DR-\d+(-AM\d+)?(\/[A-Z]+)?/ do |design|
    design.design_by_reference "designs/:reference"
    design.design_by_reference "designs/:reference.:format"
  end
  
  map.resources :designs, 
                :has_many   => :uploaded_files, 
                :member     => { :attach => :get, :amend => :get },
                :collection => { :search => :any, :cloud => :any }
  
  # Allow packagings to be accessed by reference alone; e.g. /packagings/PR-001
  map.with_options :controller => "packagings", :action => "show", :reference => /PR-\d+(-AM\d+)?(\/[A-Z]+)?/ do |packaging|
    packaging.packaging_by_reference "packagings/:reference"
    packaging.packaging_by_reference "packagings/:reference.:format"
  end
  
  map.resources :packagings, 
                :has_many   => :uploaded_files,
                :member     => { :attach => :get, :amend => :get },
                :collection => { :search => :any }
  
  map.resources :samples,
                :has_many   => [ :sample_statuses, :uploaded_files ],
                :collection => {
                  :new_sample_add_on  => :get,
                  :completed          => :get,
                  :search             => :any
                },
                :member => { 
                  :repeat => :get, 
                  :attach => :get
                }
  
  map.resources :size_charts,
                :member => {
                  :repeat               => :get
                },
                :collection => {
                  :new_measurement      => :get,
                  :new_measurement_size => :get
                }
  
  map.resources :orders, 
                :has_many => [ :statuses ], 
                :member   => {
                  :attach               => :get,
                  :contract             => :get,
                  :repeat               => :get,
                  :dispatches           => :get,
                  :additional_info			=> :get,
                  :packaging						=> :get,
                  :new_dispatch         => :get,
                  :metastatus           => :put
                },
                :collection => {
                  :new_pack             => :get,
                  :new_pack_size        => :get, 
                  :new_pack_add_on      => :get,
                  :completed            => :get,
                  :search               => :any
                }
                
  map.with_options :controller => "orders", 			:conditions => { :method => :put } do |orders|
    orders.connect 'orders/:id/dispatches', 			:action => "update_dispatches"
    orders.connect 'orders/:id/additional_info',	:action => "update_additional_info"
    orders.connect 'orders/:id/packaging',  			:action => "update_packaging"
    orders.connect 'orders/:id/attach',     			:action => "update_attachments"
    orders.connect 'orders/:id/contract',   			:action => "update_contracts"
  end
  
  map.root :orders
  
  map.connect "/", :controller => "orders", :action => "options", 
                   :conditions => { :method => :options }
                   
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
