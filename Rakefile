require 'rake'
require 'erb'

desc "Install the dot files into user's home directory. Optional: debug, verbose."
task :install do
  debug = str_to_boolean(ENV['debug'], :default => false)
  verbose = (debug || str_to_boolean(ENV['verbose'], :default => true))
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE].include?(file)
    target = File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
    if File.exist?(target)
      if File.identical?(file, target)
        puts "Identical #{target}" if verbose
      elsif replace_all
        replace_file(file, :debug => debug, :verbose => verbose)
      else
        print "Overwrite #{target}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file, :debug => debug, :verbose => verbose)
        when 'y'
          replace_file(file, :debug => debug, :verbose => verbose)
        when 'q'
          exit
        else
          puts "Skipping #{target}" if verbose
        end
      end
    else
      link_file(file, :debug => debug, :verbose => verbose)
    end
  end
end

def replace_file(file, options = {})
  target = File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
  run_command %Q{rm -rf "#{target}"}, :debug => options[:debug], :verbose => options[:verbose]
  link_file(file, :debug => options[:debug], :verbose => options[:verbose])
end

def link_file(file, options = {})
  target = File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
  if file =~ /\.erb$/
    puts "Generating #{target}" if options[:verbose]
    File.open(target, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "Linking #{target}" if options[:verbose]
    run_command %Q{ln -s "$PWD/#{file}" "#{target}"}, :debug => options[:debug], :verbose => options[:verbose]
  end
end

desc "Uninstall by removing symlinks if they exist. Optional: debug, verbose."
task :uninstall do
  debug = str_to_boolean(ENV['debug'], :default => false)
  verbose = (debug || str_to_boolean(ENV['verbose'], :default => true))
  names = %w(.ackrc .bash .bash_profile .bashrc .bin .editrc .gemrc .gitignore .gvimrc.after .gvimrc.before .inputrc .irbrc .railsrc .tmux.conf .vimrc.after .vimrc.before)
  replace_all = false
  names.each do |name|
    file = File.join(ENV['HOME'], name)
    if File.symlink?(file)
      if replace_all
        remove_link(file, :debug => debug, :verbose => verbose)
      else
        print "Remove symlink '#{file}'? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          remove_link(file, :debug => debug, :verbose => verbose)
        when 'y'
          remove_link(file, :debug => debug, :verbose => verbose)
        when 'q'
          exit
        end
      end
    end
  end
end

def run_command(cmd, options = {})
  puts cmd if options[:verbose]
  system(cmd) unless options[:debug]
end

def remove_link(file, options = {})
  FileUtils.rm(file, :noop => options[:debug], :verbose => options[:verbose])
end

def str_to_boolean(str, options = {})
  tmp = str.to_s
  if options[:default] == true
    tmp.match(/^(false|f|no|n|0)$/i) == nil
  else
    tmp.match(/^(true|t|yes|y|1)$/i) != nil
  end
end
