Gem::Specification.new do |s|
  s.name = 'bisect'
  s.version = '0.0.2'
  s.summary = %{Adds a recursive key-based bisection to Hash.}
  s.description = %{Adds a recursive key-based bisection to Hash. This allows you to ignore unwanted keys from a Hash.}
  s.authors = ["Ben Alavi"]
  s.email = ["ben.alavi@citrusbyte.com"]
  s.homepage = "http://github.com/citrusbyte/whitelist"
  s.files = ["lib/bisect.rb", "README.markdown", "LICENSE", "Rakefile", "test/all_test.rb", "bisect.gemspec"]
  s.rubyforge_project = "bisect"
end
