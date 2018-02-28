class Sieve
  attr_accessor :num_hash
  def initialize(max_num)
    @max_num = max_num
    @num_hash = {}
    (2..max_num).each { |num| num_hash[num] = false }
  end

  def primes
    nums = num_hash.keys
    index = 0
    while index < nums.size
      num_hash.each do |key, value|
        next if nums[index] == key
        num_hash[key] = true if key % nums[index] == 0
      end
      index += 1
    end

    num_hash.delete_if { |_, value| value == true }
    num_hash.keys
  end
end
