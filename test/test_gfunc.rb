require 'test/unit'
require 'debug'

class GfuncTest < Test::Unit::TestCase
  def test_english_hello
    assert_equal "hello world", Gfunc.hi("english")
  end

  def test_any_hello
    assert_equal "hello world", Gfunc.hi("ruby")
  end

  def test_spanish_hello
    assert_equal "hola mundo", Gfunc.hi("spanish")
  end
end
