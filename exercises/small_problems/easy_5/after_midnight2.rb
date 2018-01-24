HOUR = 60
DAY = HOUR * 24

def after_midnight(string_hour)
  minutes = return_minutes(string_hour)
  if minutes == DAY
    DAY - minutes
  else
    minutes
  end
end

def before_midnight(string_hour)
  minutes = return_minutes(string_hour)
  if minutes == 0
     minutes
  else
    DAY - minutes
  end
end

def return_minutes(string)
  hour, minute = string.split(":")
  hour.to_i * HOUR + minute.to_i
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0
