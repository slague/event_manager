require 'csv'
require 'sunlight/congress'
require 'erb'
# require './lib/event_attendees'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_home_phone(homephone)
  homephone.to_s.rjust(10,"0")[0..9]
end

def registration_date_and_time(regdate)
  #most common month
  #this is just a list of months... need to put in a data structure to find the most frequent
#   months = [11,..]
# freq = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
#
  months = regdate.split("/")[0]
  months
end



# freq = arr.inject

#most common month?
#look at the list of months which occurs most often 1-12?
#most common date
#most common day of the week?
#most common time of day



def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open './lib/event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  homephone = clean_home_phone(row[:homephone])
  regdate = registration_date_and_time(row[:regdate])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)
  p regdate
end
