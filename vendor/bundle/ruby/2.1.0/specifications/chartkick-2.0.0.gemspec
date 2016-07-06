# -*- encoding: utf-8 -*-
# stub: chartkick 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "chartkick"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andrew Kane"]
  s.date = "2016-05-31"
  s.description = "Create beautiful JavaScript charts with one line of Ruby"
  s.email = ["acekane1@gmail.com"]
  s.homepage = "http://chartkick.com"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "Create beautiful JavaScript charts with one line of Ruby"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
