require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/whitelist"

def params
  { :a => 1, :b => 2, :c => { :d => 3 } }
end

class WhitelistTest < Test::Unit::TestCase
  include Whitelist

  def params
    @params ||= {:foo => {:bar => 1, :baz => 2, :bars => {:qux => 3}}}
  end

  test "simple whitelist" do
    whitelist(:foo => :bar)

    assert_equal(
      {:foo => {:bar => 1}},
      params
    )
  end

  test "whitelist with many keys" do
    whitelist(:foo => [:bar, :baz])

    assert_equal(
      {:foo => {:bar => 1, :baz => 2}},
      params
    )
  end

  test "whitelist nested" do
    whitelist(:foo => [:bar, {:bars => :qux}])

    assert_equal(
      {:foo => {:bar => 1, :bars => {:qux => 3}}},
      params
    )
  end
end
