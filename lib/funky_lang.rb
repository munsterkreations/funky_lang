#!/usr/bin/env ruby

require_relative '../lib/code_generator'
require_relative 'lib/funky_lexer'
require_relative 'lib/funky_parser'
require_relative 'lib/funky_semantic_analyzer'
require_relative 'lib/funky_compiler'

class FunkyCompiler
  def initialize(input_file)
    @input_file = input_file
  end

  def compile
    # Read input code from the file
    input_code = read_input_code

    # Parse the input code
    parser = FunkyParser.new(input_code)
    parsed_code = parser.parse

    # Perform semantic analysis
    semantic_analyzer = SemanticAnalyzer.new(parsed_code)
    semantic_analyzer.analyze

    # Compile the parsed code
    compiler = Compiler.new(parsed_code)
    compiled_code = compiler.compile

    compiled_code
  end

  private

  def read_input_code
    File.read(@input_file)
  rescue StandardError => e
    puts "Error reading input file: #{e.message}"
    exit(1)
  end
end

# Main program execution
if ARGV.empty?
  puts "Usage: ruby funky.rb <input_file>"
  exit(1)
end

input_file = ARGV[0]
funky_compiler = FunkyCompiler.new(input_file)
compiled_code = funky_compiler.compile

puts "Compiled Ruby code:"
puts compiled_code
