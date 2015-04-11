mruby-catch-throw
=================
An implementation of ruby's catch and throw.

mrb_config.rb:
```ruby
MRuby::Build.new do |conf|
...
conf.gem github: 'IceDragon200/mruby-catch-throw'
...
end
```

Usage:
```ruby
# just like your regular ruby catch & throw
catch :ball do 
  pitcher.wind_up
  throw :ball
end
```
