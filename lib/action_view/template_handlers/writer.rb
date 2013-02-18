require 'pdf/simpletable'

module ActionView
  module TemplateHandlers
    class Writer < TemplateHandler
      include Compilable
      
      def compile(template)
        <<-COMPILED
        @orientation ||= :portrait
        pdf = PDF::Writer.new(:paper => 'A4', :orientation => @orientation)
        pdf.compressed = true
        pdf.select_font("Helvetica")
        pdf.margins_in(0.75, 0.75, 1.0, 0.75)
        if @header
          pdf.open_object do |heading|
            pdf.save_state
            s = 12
            w = pdf.text_width(@header, s) / 2.0
            pdf.add_text(pdf.margin_x_middle - w, pdf.absolute_top_margin + 10, @header, s)
            pdf.restore_state
            pdf.close_object
            pdf.add_object(heading, :all_pages)
          end
        end
        pdf.start_page_numbering(pdf.margin_x_middle, pdf.bottom_margin / 2, 10, nil, nil, 1)
        #{template.source}
        pdf.stop_page_numbering(true)
        pdf.render
        COMPILED
      end
    end
  end
end
