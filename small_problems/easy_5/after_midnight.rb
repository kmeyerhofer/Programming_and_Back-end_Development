def time_of_day(minutes)
  if minutes < 0
    hour = minutes / 60 + 24
    hour %= 24 if hour < 24
    minute = minutes % 60
  else
    hour = minutes / 60
    hour %= 24 if hour > 24
    minute = minutes % 60
  end
"#{sprintf("%02d", hour)}:#{sprintf("%02d", minute)}"
end

time_of_day(0) == "00:00"
time_of_day(-3) == "23:57"
time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"
