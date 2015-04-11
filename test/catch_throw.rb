assert 'throw should raise an UncaughtThrowError' do
  assert_raise UncaughtThrowError do
    throw :elephant
  end
end

assert 'throw and catch' do
  n = 0
  m = 0
  catch :ball do
    7.times do |i|
      # n should be 5 when the ball is thrown
      throw :ball if i > 4
      n += 1
    end
    # this should never be set
    m = 1
  end
  n == 5 and m == 0
end
