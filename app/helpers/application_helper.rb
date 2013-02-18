# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def flashes
    flash.map {|type, message| content_tag(:p, message, :class => type) }.join
  end
  
  def new_or_existing(record)
    record.new_record? ? 'new' : 'existing'
  end
  
  def breadcrumbs
    levels = request.path.split('?')[0].split('/')
    levels.delete_at(0)
    
    links = []
    
    links << (levels.empty? ? 'Home' : link_to('Home', root_path))
    
    levels.each_with_index do |level, index|
      title = if level.is_i? && model_class = levels[index - 1].is_active_record?
        record = model_class.find(level)
        if record.respond_to?(:reference)
          record.reference
        elsif record.respond_to?(:name)
          record.name
        else
          level
        end
      else
        level.titleize
      end
      
      if index == levels.length - 1
        links << title
      else
        links << link_to(title, "/#{levels[0..index].join('/')}")
      end
    end
    
    links.join(' &rarr; ')
  end
  
  def current_tab(controller_name)
    ' class="current"' if controller.controller_name == controller_name
  end
  
  def na(something)
    something.blank? ? '<span class="na">N/A</span>' : something
  end
  
  def yes_or_no(something)
    something ? 'Yes' : 'No'
  end
  
  def na_pdf(something)
    if something.blank?
      'N/A'
    else
      something
    end
  end
  
  def tick(predicate)
    if predicate
      '<img src="/images/tick.png" alt="Yes" width="16" height="16" />'
    else
      '<img src="/images/cross.png" alt="No" width="16" height="16" />'
    end
  end
end
