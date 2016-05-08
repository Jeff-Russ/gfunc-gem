
    ######--------------------------------------------######
    ######  By Jeff Russ https://github.com/Jeff-Russ ######
    ######--------------------------------------------######

$gfunc_info = <<-msg
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

module TopLevel # directly in main to make TopLevel: extend TopLevel
#    __________________________________________________________________
#   /                 File i/o methods                                 \

  # `file_insert` inserts contents of `s_or_a_ins` in `file_path_str` at 
  # `linenum`. When `file_path_str` will honor "\n" and generate a newline.
  # This way you can enter a large string with lines delimited by your "\n".
  # Alternatively, you can use an array of strings, Each will be a new line.
  # Note: `linenum` starts at 1, NOT 0 and can be negative (-1 is last line)
  def file_insert file_path_str, s_or_a_ins='', linenum=-1
    FileUtils.touch(file_path_str) unless File.exist? file_path_str
    arr = File.read(file_path_str).lines(separator="\n")
    linenum-=1 if linenum > 0
    s_or_a_ins.each { |e| e << "\n" } if s_or_a_ins.class == Array 
    arr.insert linenum, s_or_a_ins
    string = arr.join
    File.open(file_path_str, "w+") { |f| f.write(string) }
  end

  # `file_to_a` reads file at `file_path_str` and returns array of strings.
  # Each line will be a new element by default since `file_to_a`
  # looks for "\n" when breaking up the file into the array but you can 
  # override this with any double-quoted character as the optional 2nd arg
  def file_to_a file_path_str, delimiter="\n"
    File.read(file_path_str).lines(separator=delimiter)
  end

  # `s_to_file` overwrites file at `file_path_str` with `new_content_str` 
  def s_to_file file_path_str, new_content_str='' 
    File.open(file_path_str, "w+") { |f| f.write(new_content_str) }
  end

#    ___________________________________________________________________
#   /                 Other file related methods                        \

  # `ls_grep?` helps you see if a directory `dir_str` contains a directory
  # or file with a name containing a string provided 2nd arg `grep_str`,
  # The 1st arg is assumed to be a full path unless you provide a 3rd arg.
  # The 3rd arg can be `:ror` for the root of the current Rails app, 
  # `:home` for the user's home folder or a custom path as a string.
  def ls_grep? dir_str, grep_str, dir_parent_sym_or_s="/"
    dir_str.gsub /^\//, '' # remove starting '/' if found
    case parent_path 
    when :ror   then parent = Rails.root
    when :home  then parent = Dir.home
    when String then parent = dir_parent_sym_or_s
    end
    ls_cmd = "ls #{Rails.root}/#{dir_str} | grep '#{grep_str}'"
    (%x[ #{ls_cmd} ]) != ''
  end

  # Location the definition of just about anything.
  def locate_def str
    has_dot = has_dot? str
    str_upr = starts_upper? str
    if has_dot && str_upr
      splits = str.partition(".")
      clas = splits.first
      meth = splits.last
      eval "clas.method(meth).source_location"
    elsif !has_dot && !str_upr
      Object.method(str).source_location
    elsif 
      code = "#{str}.instance_methods(false).map {|m| #{str}"
      code << ".instance_method(m).source_location.first}.uniq"
      eval code
    end
  end

  def ror_path str # appends string arg with Rails.root
    "#{Rails.root}#{str}" 
  end 

  def ror_file_exists? str
    File.exist? "#{Rails.root}#{str}"
  end

#    __________________________________________________________________
#   /         Rails bash commands made available in Ruby               \

  def g_model str # rails generate model ..., just like in shell
    cmd = "rails generate model #{str}"
    puts %x[ #{cmd} ]
  end

  def d_model str # rails destroy model ..., just like in shell
    cmd = "rails destroy model #{str}"
    puts %x[ #{cmd} ]
  end

  def g_cont str # rails generate controller ..., just like in shell
    cmd = "rails generate controller #{str}"
    puts %x[ #{cmd} ]
  end

  def d_cont str # rails destroy controller ..., just like in shell
    cmd = "rails destroy controller #{str}"
    puts %x[ #{cmd} ]
  end

#    __________________________________________________________________
#   /              Rails ActiveRecord shortcuts                        \

  # finds migration file containing string provided by arg, returns id
  def get_migration_id partial_filename
    ls_migr_file = "ls #{Rails.root}/db/migrate | grep '#{partial_filename}'"
    (%x[ #{ls_migr_file} ]).strip.gsub!(/\D/, '')
  end

  # Runs migration `:up` or `:down` set by 2nd arg (defaulted to `:up`)
  # for migration file specified by any part of it's name as 1st arg (string).
  def run_migration_file partial_filename, direction=:up
    id = get_migration_id partial_filename
    "rake db:migrate:#{direction.to_s} VERSION=#{id}"
  end

  # get migration status as string
  def migration_status 
    stat = "rake db:migrate:status"
    %x[ #{stat} ] 
  end

  # get array of table names in less annoying syntax:
  def tables; ActiveRecord::Base.connection.tables; end 

  def table_exists? str # arg should be actual table name on db
    ActiveRecord::Base.connection.tables.include? str
  end 

#    _____________________________________________________________
#   /         String Manipulation and Evaluation                  \

  # These are all self-explanatory. all return booleans
  def is_upper?  str; str == str.upcase; end
  def is_lower?  str; str == str.downcase; end
  def has_regex? str, regex; !!(str =~ regex); end
  def has_dot?   str, regex; !!(str =~ /\./); end
  def has_upper? str; !!(str =~ /[A-Z]/); end
  def has_lower? str; !!(str =~ /[A-Z]/); end
  def starts_upper? str; !!(str.first =~ /[A-Z]/); end
  def starts_lower? str; !!(str.first =~ /[A-Z]/); end

  def prepend_each array, left_side
    array.map { |elem| elem = "#{left_side}#{elem}" }
  end
 
  def append_each array, right_side
    array.map { |elem| elem = "#{left_side}#{elem}#{right_side}" }
  end

  def wrap_each array, left_side, right_side
    array.map { |elem| elem = "#{left_side}#{elem}#{right_side}" }
  end
end

# An optional wrapper around TopLevel's methods 
# to make them namespaced and Class methods
module Gfunc 
  class << self # DO NOT change to module!
    include TopLevel
  end
  def self.source return_string=false
    unless return_string
      puts File.read(__FILE__)
    else return File.read(__FILE__)
    end
  end
  def self.puts_methods
    puts TopLevel.instance_methods
  end

end


