# Gfunc

Gfunc is a small collection of multi-purpose utilities by Jeff-Russ

GFunc == Global Functions and yes, I know that "top-level functions"
are actually methods of the Object class but Gmeth? I'd rather the name be 
a reference to G-funk than METHAMPHETAMINE.

Here, have a list of all the methods:

	file_insert    file_to_a    s_to_file    ls_grep?    locate_def
	
	ror_path  ror_file_exists?   g_model   d_model   g_cont   d_cont

	get_migration_id  run_migration_file  migration_status  tables

	table_exists?    is_upper?   is_lower?   has_regex?   has_dot?

	has_upper?    has_lower?   starts_upper?  starts_lower?

	prepend_each   append_each    wrap_each


### Installation

This gem is not yet publishing on RubyGems.org so You'll have to install 
it this way for now:

First clone or download the repo then fire up terminal and cd to the directory

	$ gem build gspec.gemspec
	$ ls # look for gfunc*.gem.
	$ # Your version number might differ:
	$ gem install ./gfunc-0.0.1.gem 

Eventually You'll be able install this way instead:

	$ gem install 'gfunc'

Optionally, add to Ruby on Rails Gemfile

	gem 'gfunc'

### Use

Gfunc's utilities are provided as top-level methods via:

	require 'gfunc'

or as Gfunc class methods:

	require 'gfunc/core'

### Getting Info

With the first way, methods are called directly, like functions. 
The second way requires: 

	Gfunc.methodname

Display all methods in irb:

	Gfunc.puts_methods

Display (heavily commented) code:

	Gfunc.source

Display this message again:

	puts $gfunc_info

