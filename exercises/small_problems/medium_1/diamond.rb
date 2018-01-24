def diamond(size)
  half = size / 2
  half_sp = ' ' * (size / 2)
  middle = '*' * size
  space = ' ' * size
  top_half(size)
  puts middle
  bottom_half(size)
end

def top_half(size)
  size.times do |num|
    if num.odd?
    star = '*' * num
    puts star.center(size)
    end
  end
end

def bottom_half(size)
  size.times do |num|
    if num.odd?
    star = '*' * (size - num - 1)
    puts star.center(size)
    end
  end
end

diamond(1)
diamond(3)
diamond(9)
diamond(11)
