require 'minitest/autorun'
require_relative 'easy_test_class'

class BooleanTest < MiniTest::Test
  def test_odd?
    value = Value.new(6)
    assert_equal(false, value.odd?)
    value = Value.new(7)
    assert_equal(true, value.odd?)
  end

  def test_downcase
    value = 'XYZ'
    assert_equal('xyz', value.downcase)
  end

  def test_value_nil
    value = nil
    assert_nil(value)
  end

  def test_empty_list?
    list = []
    assert_equal(true, list.empty?)
    assert_empty(list)
  end

  def test_xyz_list
    list = ['xyz']
    assert_equal(true, list.include?('xyz'))
    assert_includes list, 'xyz'
  end

  def test_employee_experience
    employee = Value.new('Sam')
    assert_raises NoExperienceError do
      employee.hire
    end
  end

  def test_numeric_class
    value = Numeric.new
    assert_equal(Numeric, value.class)
    assert_instance_of Numeric, value
  end

  def test_numeric_or_children
    value = 3
    assert_kind_of Numeric, value
  end

  def test_list
    list = []
    assert_same list, list
  end

  def test_list_items
    list = ['xyza']
    refute_includes list, 'xyz'
  end
end
