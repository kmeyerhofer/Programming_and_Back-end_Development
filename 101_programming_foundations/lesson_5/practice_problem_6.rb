munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def prompt(name, age, gender)
  puts "#{name} is a #{age}-year-old #{gender}."
end

munsters.each_pair do |name, values|
  prompt(name, values["age"], values["gender"])
end
