# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @empty_stack = Stack.new
    @stack = Stack.new([1, 2, 3])
  end

  def teardown; end

  def test_if_stack_empty
    assert_equal @empty_stack.to_a, []
    assert_equal @empty_stack.size, 0
    assert @empty_stack.empty?

    3.times { @stack.pop! }
    assert_equal @stack.to_a, []
    assert_equal @stack.size, 0
    assert @stack.empty?
  end

  def test_add_element
    @stack.push! 4
    assert_equal @stack.size, 4
  end

  def test_remove_element
    popped_values = []
    sizes = []
    5.times do
      popped_values << @stack.pop!
      sizes << @stack.size
    end
    assert_equal popped_values, [3, 2, 1, nil, nil]
    assert_equal sizes, [2, 1, 0, 0, 0]
  end

  def test_clearing
    @stack.clear!
    assert @stack.empty?
    assert_equal @stack.size, 0
  end

  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
