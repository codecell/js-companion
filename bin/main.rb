#!/usr/bin/env ruby
require_relative '../lib/helpers/lint_ware'
require 'tty-font'
require 'colorize'

def show_title
  font = TTY::Font.new
  font_messge = font.write('Js Companion', letter_spacing: 1)
  puts font_messge
end

def print_linter_result(error_bin, fpath)
  puts
  puts "#{error_bin.length.to_s.yellow} Offense(s) Detected" unless error_bin.empty?

  path_exists = File.exist?(fpath) || Dir.exist?(fpath)

  success_msg = 'As clean as Snow!. No offenses found in the $PATH'

  puts "#{success_msg} #{fpath}".green if error_bin.empty? && path_exists == true
  puts
end

def js_companion_init
  show_title

  return unless ARGV.length.positive?

  path = ARGV[0]

  error_bin = []

  js_file_pattern = /(\w|\W)+.js$/

  if js_file_pattern.match?(path)
    LintWare.init_files_linting(error_bin, path)
  else
    LintWare.init_dir_linting(error_bin, path)
  end

  print_linter_result(error_bin, path)
end

js_companion_init
