class DNA
  def initialize(sequence)
    @sequence = sequence
  end

  def hamming_distance(second_sequence)
    shortest_sequence = setup_shortest_sequence(second_sequence)
    index = 0
    counter = 0
    while index < shortest_sequence
      counter += 1 if @sequence[index] != second_sequence[index]
      index += 1
    end
    counter
  end

  def setup_shortest_sequence(second_sequence)
    if @sequence.length < second_sequence.length
      @sequence.length
    elsif second_sequence.length < @sequence.length
      second_sequence.length
    else
      @sequence.length
    end
  end
end
