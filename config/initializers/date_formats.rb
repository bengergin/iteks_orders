Date::DATE_FORMATS[:with_day_of_week] = lambda { |date| date.strftime("%A, #{date.day.ordinalize} %B %Y") }
Time::DATE_FORMATS[:with_day_of_week] = lambda { |date| date.strftime("%A, #{date.day.ordinalize} %B %Y") }

Date::DATE_FORMATS[:euro] = lambda { |date| date.strftime("#{date.day.ordinalize} %B %Y") }
Time::DATE_FORMATS[:euro] = lambda { |date| date.strftime("#{date.day.ordinalize} %B %Y") }

Date::DATE_FORMATS[:day_month_year] = "%d/%m/%y"
Time::DATE_FORMATS[:day_month_year] = "%d/%m/%y"
