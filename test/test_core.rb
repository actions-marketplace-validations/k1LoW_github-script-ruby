# frozen_string_literal: true

require 'test/unit'
require_relative "../lib/github/actions/toolkit"

class TestCore < Test::Unit::TestCase
  def test_get_input
    want = 'Hello, world!'
    ENV['INPUT_HELLO'] = want
    core = GitHub::Actions::Toolkit::Core.new
    assert_equal want, core.get_input('hello')
  end

  def test_get_input_hyphen
    # Ruby can get environment variables with hyphenated names,
    # but it cannot get environment variables with hyphenated names via docker command
    want = 'Hello, world!'
    ENV['INPUT_INPUT-VALUE'] = want
    core = GitHub::Actions::Toolkit::Core.new
    assert_equal want, core.get_input('input-value')
  end

  def test_make_output
    want = '::set-output name=prop::value'
    core = GitHub::Actions::Toolkit::Core.new
    assert_equal want, core.make_output('prop', 'value')
  end
end
