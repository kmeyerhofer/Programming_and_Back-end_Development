# Problem 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

# Problem 2 & 3
ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 5843, 'Eddie' => 10, 'Marilyn' => 22, 'Spot' => 237 }
ages.values.reduce(:+)

ages.delete_if { |_, age| age > 100 }

# Problem 4
family_age = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 5843, 'Eddie' => 10, 'Marilyn' => 22, 'Spot' => 237 }
family_age.values.min

# Problem 5
flintstones.find_index { |name| name.include?("Be") }

# Problem 6
flintstones.map! { |name| name[0, 3] }

# Problem 7
statement = 'The Flintstones Rock'
statement_count = {}
statement.split('').each do |letter|
  statement_count[letter] = statement.count(letter)
end

# Problem 8
# The output to the screen is "1  2  3  4" from p, and an empty array.
# The output to the screen is "1  2" from p, and numbers containing [1, 2]

# Problem 9
words = 'the flintstones rock'
titler = words.split.map { |word| word.capitalize! }.join(' ')

# Problem 10
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, groups|
  if groups["age"].between?(0,17)
    groups["age_group"] = "kid"
  elsif groups["age"].between?(18,64)
    groups["age_group"] = "adult"
  elsif groups["age"] > 64
    groups["age_group"] = "senior"
  end
end
p munsters
