require "csv"
require 'google/apis/civicinfo_v2'
require "erb"

def clean_zip_code(zip_code)
  zip_code.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  phone_number.gsub!(/[^\d]/,'')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 10 && phone_number[0] = 1
    phone_number[1..10]
  else
    "Bad Number"
  end
end

def legislators_by_zip_code(zip_code)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    legislators = civic_info.representative_info_by_address(
    address: zip_code,
    levels: 'country',
    roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(", ")
  rescue 
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, personal_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts personal_letter
  end
end

def count_frequency(array)
  array.max_by {|a| array.count(a)}
end

puts "Event manager Initialized"
contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
hour_of_the_day = []
week_of_the_day = []
cal = {0=>"sunday",1=>"monday",2=>"tuesday",3=>"wednesday",4=>"thursday",5=>"friday",6=>"saturday"}
contents.each do |row|
  id = row[0]
  zip_code = clean_zip_code(row[:zipcode])
  legislators = legislators_by_zip_code(zip_code)
  phone_number = clean_phone_number(row[:homephone])
  reg_date = row[:regdate]
  reg_date_to_print = DateTime.strptime(reg_date,"%m/%d/%y %H:%M")
  hour_of_the_day.push(reg_date_to_print.hour)
  week_of_the_day.push(reg_date_to_print.wday)
  personal_letter = erb_template.result(binding)
  save_thank_you_letter(id, personal_letter)
end
p hour_of_the_day
p week_of_the_day
puts "Most Active Hour is : #{count_frequency(hour_of_the_day)}"
puts "Most Active Day is : #{cal[count_frequency(week_of_the_day)].capitalize}"

