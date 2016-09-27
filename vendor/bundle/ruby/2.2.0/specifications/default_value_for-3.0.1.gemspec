# -*- encoding: utf-8 -*-
# stub: default_value_for 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "default_value_for"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Hongli Lai"]
  s.date = "2014-12-23"
  s.description = "The default_value_for plugin allows one to define default values for ActiveRecord models in a declarative manner"
  s.email = "software-signing@phusion.nl"
  s.homepage = "https://github.com/FooBarWidget/default_value_for"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.4.5.1"
  s.summary = "Provides a way to specify default values for ActiveRecord models"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["< 5.0", ">= 3.2.0"])
      s.add_development_dependency(%q<railties>, ["< 5.0", ">= 3.2.0"])
      s.add_development_dependency(%q<minitest>, [">= 4.2"])
      s.add_development_dependency(%q<minitest-around>, [">= 0"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["< 5.0", ">= 3.2.0"])
      s.add_dependency(%q<railties>, ["< 5.0", ">= 3.2.0"])
      s.add_dependency(%q<minitest>, [">= 4.2"])
      s.add_dependency(%q<minitest-around>, [">= 0"])
      s.add_dependency(%q<appraisal>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["< 5.0", ">= 3.2.0"])
    s.add_dependency(%q<railties>, ["< 5.0", ">= 3.2.0"])
    s.add_dependency(%q<minitest>, [">= 4.2"])
    s.add_dependency(%q<minitest-around>, [">= 0"])
    s.add_dependency(%q<appraisal>, [">= 0"])
  end
end
