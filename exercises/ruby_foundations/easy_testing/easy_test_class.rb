class NoExperienceError < StandardError; end

class Value
  def initialize(value)
    @value = value
  end

  def value
    @value
  end

  def odd?
    @value.odd?
  end

  def hire
    raise NoExperienceError
  end

  def process
    @value
  end
end
