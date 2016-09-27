# -*- encoding: utf-8 -*-
# stub: thin 1.6.4 ruby lib
# stub: ext/thin_parser/extconf.rb

Gem::Specification.new do |s|
  s.name = "thin"
  s.version = "1.6.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Marc-Andre Cournoyer"]
  s.date = "2015-09-19"
  s.description = "A thin and fast web server"
  s.email = "macournoyer@gmail.com"
  s.executables = ["thin"]
  s.extensions = ["ext/thin_parser/extconf.rb"]
  s.files = ["bin/thin", "ext/thin_parser/extconf.rb"]
  s.homepage = "http://code.macournoyer.com/thin/"
  s.licenses = ["GPLv2+", "Ruby 1.8"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.5")
  s.rubyforge_project = "thin"
  s.rubygems_version = "2.4.5.1"
  s.summary = "A thin and fast web server"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.0"])
      s.add_runtime_dependency(%q<eventmachine>, [">= 1.0.4", "~> 1.0"])
      s.add_runtime_dependency(%q<daemons>, [">= 1.0.9", "~> 1.0"])
    else
      s.add_dependency(%q<rack>, ["~> 1.0"])
      s.add_dependency(%q<eventmachine>, [">= 1.0.4", "~> 1.0"])
      s.add_dependency(%q<daemons>, [">= 1.0.9", "~> 1.0"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.0"])
    s.add_dependency(%q<eventmachine>, [">= 1.0.4", "~> 1.0"])
    s.add_dependency(%q<daemons>, [">= 1.0.9", "~> 1.0"])
  end
end
