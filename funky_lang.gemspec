Gem::Specification.new do |s|
  s.name        = 'funky_lang'
  s.version     = '0.1.0'
  s.summary     = %q{A Ruby library for working with the Funky programming language.}
  s.description = %q{The Funky gem provides tools for lexing, parsing, compiling, and executing Funky code.
                    It includes components such as a lexer, parser, compiler, and semantic analyzer, as well as console tools and binary executables for interacting with Funky code.}
  s.authors     = ['MONSTERCRYST']
  s.homepage    = 'https://github.com/munsterkreations/funky_lang'
  s.license     = 'Apache-2.0'
  s.email       = ['100237939+monstergenes@users.noreply.github.com']
  s.files       = Dir.glob(%w[lib/**/*.rb bin/* *.md LICENSE])

  # Correct executables setup
  s.executables = ["funky-console.rb"]
  s.bindir = 'bin' # Specify the bin directory
 
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "jekyll", "~> 4.3.3"
  
  s.metadata["allowed_push_host"] = "https://rubygems.org"
  s.metadata['source_code_uri'] = 'https://github.com/munsterkreations/funky_lang'
end











