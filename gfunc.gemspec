Gem::Specification.new do |s|
  s.name               = "gfunc"
  s.version            = "0.0.1"
  s.default_executable = "gfunc"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Russ"]
  s.date = %q{2015-05-07}
  s.description = %q{A collection of utilities optionally provided as top-level methods}
  s.email = %q{jeffreylynnruss@gmail.com}
  s.files = ["Rakefile", "lib/gfunc.rb", "lib/gfunc/core.rb", "bin/gfunc"]
  s.test_files = ["test/test_gfunc.rb"]
  s.homepage = %q{https://github.com/Jeff-Russ/gfunc-gem}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{gfunc}
  s.license = "MIT"
  s.post_install_message = <<-msg
------------------------------------------------------
Gfunc is a collection of utilities by Jeff-Russ

provided as top-level methods:    require 'gfunc'
or as Gfunc class methods:        require 'gfunc/core'

With the first way, methods are called directly, like 
functions. The second way requires: Gfunc.methodname

Display all methods in irb:       Gfunc.puts_methods
Display (heavily commented) code: Gfunc.source
Display this message again:       puts $gfunc_info

More info: https://github.com/Jeff-Russ/gfunc-gem
------------------------------------------------------
msg

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

