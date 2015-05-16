# Exception raised by a throw
class UncaughtThrowError < ArgumentError
  # @!attribute [r] thrown
  #   @return [Object] thrown object, mostly a Symbol
  attr_reader :thrown
  # @!attribute [r] param
  #   @return [Array] extra parameters passed in
  attr_reader :param

  # @param [Object] obj  object to throw
  def initialize(obj, param = nil)
    @thrown = obj
    @param = param
    super "uncaught throw #{obj}"
  end
end

module Kernel
  # Throws an object, uncaught throws will bubble up through other catch blocks.
  #
  # @param [Object] obj  object to throw
  # @raises [UncaughtThrowError]
  # @return [void] it will never return normally.
  #
  # @example
  #   catch :ball do
  #     pitcher.wind_up
  #     throw :ball
  #   end
  def throw(obj, arg = nil)
    raise UncaughtThrowError.new(obj, arg)
  end

  # Setup a catch block and wait for an object to be thrown, the
  # catch end without catching anything.
  #
  # @param [Object] expected  object to catch
  # @return [void]
  #
  # @example
  #   catch :thing do
  #     __do_stuff__
  #     throw :thing
  #   end
  def catch(expected)
    yield
  rescue UncaughtThrowError => ex
    raise ex unless ex.thrown == expected
    ex.param
  end
end
