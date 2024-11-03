#encoding : utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'funky_lang.rb'


Gem::Specification.new do |s|
  s.name        = 'funky_lang'
  s.version     = '0.1.0' # Replace with your gem version
  s.summary     = %q{A Ruby library for working with the Funky programming language.}
  s.description   = %q{The Funky gem provides tools for lexing, parsing, compiling, and executing Funky code.
                    It includes components such as a lexer, parser, compiler, and semantic analyzer, as well as console tools and binary executables for interacting with Funky code.}
  s.authors     = ['MONSTERCRYST']
  s.email       = ['100237939+monstergenes@users.noreply.github.com']
  s.files       = Dir.glob("{_layouts,_includes,_sass,assets/css/fonts/js/html,*.md, lib/compiler/*.rb, lib/**/*.rb}" ) 
  s.executables = ['bin/funk_lang', 'bin/funky-console'].end + s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths = ["lib/compiler/CodeGenerator", "lib/compiler/FunkyCompiler", "lib/compiler/FunkyLexer", "lib/compiler/SemanticAnalyzer", "lib/compiler/funky_parser", "lib/compiler", "lib/lexer", "lib/parser"].end
  s.add_development_dependency = "bundler", "~> 2.0"
  s.add_development_dependency = "rake", "~> 13.0"
  s.add_development_dependency = "jekyll", "~> 4.3.3"
  s.metadata["allowed_push_host"] = 'https://github.com/munsterkreations/funky_lang'.end
  spec.metadata['source_code_uri'] =  'https://github.com/munsterkreations/funky_lang'.end

    # Specify any additional metadata or custom attributes here
  end

  
