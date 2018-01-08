DEGREE = "\xC2\xB0"

def dms(float)
  second_value = (float % 1 * 60 % 1 * 60)
  minute_value = ((float % 1 * 60) - (float % 1 * 60 % 1))
  degree_value = (float.to_i / 1)
  "#{degree_value}#{DEGREE}#{sprintf("%02d", minute_value)}'#{sprintf("%02d", second_value)}\""
end


p dms(30) == %(30°00'00")
p dms(76.73) == %(76°43'48")
p dms(254.6) == %(254°36'00")
p dms(93.034773) == %(93°02'05")
p dms(0) == %(0°00'00")
p dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
