# -*- encoding: utf-8 -*-
# stub: redis-objects 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "redis-objects"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nate Wiger"]
  s.date = "2015-11-01"
  s.description = "Map Redis types directly to Ruby objects. Works with any class or ORM."
  s.email = ["nwiger@gmail.com"]
  s.homepage = "http://github.com/nateware/redis-objects"
  s.licenses = ["Artistic"]
  s.rubygems_version = "2.2.0"
  s.summary = "Map Redis types directly to Ruby objects"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, [">= 3.0.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bacon>, [">= 0"])
      s.add_development_dependency(%q<connection_pool>, [">= 0"])
      s.add_development_dependency(%q<redis-namespace>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, ["~> 4.2"])
    else
      s.add_dependency(%q<redis>, [">= 3.0.2"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bacon>, [">= 0"])
      s.add_dependency(%q<connection_pool>, [">= 0"])
      s.add_dependency(%q<redis-namespace>, [">= 0"])
      s.add_dependency(%q<activerecord>, ["~> 4.2"])
    end
  else
    s.add_dependency(%q<redis>, [">= 3.0.2"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bacon>, [">= 0"])
    s.add_dependency(%q<connection_pool>, [">= 0"])
    s.add_dependency(%q<redis-namespace>, [">= 0"])
    s.add_dependency(%q<activerecord>, ["~> 4.2"])
  end
end
