Gem::Specification.new do |s|
  s.name        = 'litmos-api-client'
  s.version     = '0.0.4'
  s.date        = '2014-05-09'
  s.summary     = "Simple lib to consume litmos api"
  s.description = "Simple lib to consume litmos api from litmos platform"
  s.authors     = ["Fabien Garcia"]
  s.email       = 'fab0670312047@gmail.com'
  s.files       = ["lib/litmos-api-client.rb"]
  s.files = [
    "lib/litmos-api-client.rb",
    "lib/litmos_api_client.rb",
    "lib/litmos_api_client/courses.rb",
    "lib/litmos_api_client/teams.rb",
    "lib/litmos_api_client/users.rb",
    "litmos-api-client.gemspec"
  ]
  s.homepage = 'https://github.com/garciaf/litmos-api-client'
  s.license = 'MIT'

  s.add_runtime_dependency 'rest-client', '~> 1'
  s.add_development_dependency 'rake',  '~> 10.3'
  s.add_development_dependency 'rspec', '~> 2.14'
end