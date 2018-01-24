DAYS_IN_YEAR = 365
SECONDS_IN_DAY = 86400

def friday_13th(year)
  increment_days = Time.gm(year)
  thirteen_count = 0
  DAYS_IN_YEAR.times do |_|
    thirteen_count +=1 if increment_days.friday? && increment_days.day == 13
    increment_days += SECONDS_IN_DAY
  end
  thirteen_count
end

p friday_13th(2015) == 3
p friday_13th(1986) == 1
p friday_13th(2019) == 2
