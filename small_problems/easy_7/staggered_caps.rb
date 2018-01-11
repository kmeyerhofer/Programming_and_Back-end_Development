def staggered_case(sentence)
  sentence_array = sentence.chars
  index = 0
  counter = 0
  loop do
    if counter.even?
      if sentence_array[index].match?(/[a-z]/)
        sentence_array[index] = sentence_array[index].upcase
        counter +=1
      elsif sentence_array[index].match?(/[A-Z]/)
        counter +=1
      end
    elsif counter.odd?
      if sentence_array[index].match?(/[A-Z]/)
        sentence_array[index] = sentence_array[index].downcase
        counter += 1
      elsif sentence_array[index].match?(/[a-z]/)
        counter +=1
      end
    else
    end
    index += 1
    break if index == sentence.length
  end
  p sentence_array.join
end


p staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
p staggered_case('ALL CAPS') == 'AlL cApS'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'
