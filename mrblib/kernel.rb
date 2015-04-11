# Exception raised by a throw
class UncaughtThrowError < ArgumentError
  # @!attribute [r] thrown
  #   @return [Object] thrown object, mostly a Symbol
  attr_reader :thrown

  # @param [Object] obj  object to throw
  def initialize(obj)
    @thrown = obj
    super "uncaught throw #{obj}"
  end
end

module Kernel
  # Throws an object, uncaught throws will bubble up through other catch blocks.
  #
  # @param [Object] obj  object to throw
  # @raises [UncaughtThrowError]
  # @return [Void] it will never return normally.
  #
  # @example
  #   catch :ball do
  #     pitcher.wind_up
  #     throw :ball
  #   end
  def throw(obj)
    raise UncaughtThrowError.new(obj)
  end

  # Setup a catch block and wait for an object to be thrown, the
  # catch end without catching anything.
  #
  # @param [Object] expected  object to catch
  # @return [Void]
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
  end
end
