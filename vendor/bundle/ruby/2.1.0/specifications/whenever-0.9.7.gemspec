# -*- encoding: utf-8 -*-
# stub: whenever 0.9.7 ruby lib

Gem::Specification.new do |s|
  s.name = "whenever"
  s.version = "0.9.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Javan Makhmali"]
  s.date = "2016-06-14"
  s.description = "Clean ruby syntax for writing and deploying cron jobs."
  s.email = ["javan@javan.us"]
  s.executables = ["whenever", "wheneverize"]
  s.files = ["bin/whenever", "bin/wheneverize"]
  s.homepage = "https://github.com/javan/whenever"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.2.0"
  s.summary = "Cron jobs in ruby."

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<chronic>, [">= 0.6.3"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.5"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<chronic>, [">= 0.6.3"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0.9.5"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<chronic>, [">= 0.6.3"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0.9.5"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
