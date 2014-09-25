# 5631286221 Chaloemchai Thanetanukun
require 'sinatra'
require 'geocoder'
require 'timezone'

get '/' do 
	"This is an EXAMPLE of SIMPLE SERVER (from terminal web.rb)"
end

# Testing...
get '/enterCity/?:name?' do
	"Your city is >>> #{params[:name] ? params[:name] :'There is nothing!'}"
end

# Work to Submit
get '/time' do
  erb :form
end
 
Timezone::Configure.begin do |call| 
  # get your username from http://www.geonames.org/login 
  # then go to http://www.geonames.org/manageaccount and click enable at the bottom of the page
  call.username = 'aumaum_th'
end

post '/form' do
  city = params[:message]
  code = Geocoder.coordinates(city)
  timezone = Timezone::Zone.new(:latlon => code)
 
  tz = timezone.time Time.now # tz = 2014-09-23 13:46:25 UTC
  th = tz.to_s.split(' '); # th = [2014-09-23] , [13:46:25] , [UTC]
  time = th[1].split(':'); # time = [13],[46],[25]
s
  hour = time[0].to_i # hour = 13
  minute = time[1].to_i; # minute = 46
  sec = time[2].to_i; # sec =25

  secs = sec.to_s;
  if (sec<10)
    secs="0"+secs
  end
  if (hour>12)
    hour-=12
    ampm = " PM"
  else
    ampm = " AM"
  end
  "<left><h4>The current time in #{city} is </h4> <h3> #{hour}:#{minute}:#{secs} #{ampm} </h3><center/>"
 
end