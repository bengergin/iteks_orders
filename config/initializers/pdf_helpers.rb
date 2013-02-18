module PDF
  class Writer
    def spacer(font_size=7)
      text("\n", :font_size => font_size)
    end
  
    def header(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}  
      text("<b>#{args.first}</b>", {:font_size => 13}.merge(options))
    end
  
    alias_method :h1, :header
  
    def h2(*args)
      options = args.last.is_a?(Hash) ? pop : {}
      header(args.first, options.merge(:font_size => 11))
    end
  
    def h3(*args)
      options = args.last.is_a?(Hash) ? pop : {}
      header(args.first, options.merge(:font_size => 9))
    end
  end
end

module PDF
  class SimpleTable
    def defaults!
      self.position = :left
      self.orientation = :right
      self.heading_font_size = 9
      self.font_size = 8
      self.shade_headings = true
    end
  
    def easy_rows(*row_data)
      final_data = []
      i = -1
      row_data.each do |row|
        hash_data = {}
        row.each { |cell| hash_data[column_order[i += 1]] = cell }
        final_data << hash_data
        i = -1
      end
      self.data = final_data
    end 
  end
end