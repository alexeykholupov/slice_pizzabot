Gem::Specification.new do |s|
  s.name         = 'slice_pizzabot'
  s.version      = '0.1.2'
  s.date         = '2021-01-20'
  s.summary      = 'Pizza Delivery Bot'
  s.description  = 'Returns delivery instructions for pizzabot'
  s.authors      = ['Aliaksei Khalupau']
  s.email        = 'alexey.kholupov@gmail.com'
  s.files        = ['lib/pizzabot.rb', 'lib/pizzabot/address_error.rb',
                    'lib/pizzabot/grid_error.rb', 'lib/pizzabot/route_service.rb']
  s.homepage     = 'https://rubygems.org/gems/slice_pizzabot'
  s.license      = 'MIT'
  s.executables  = ['pizzabot']
  s.add_development_dependency 'rspec'
end
