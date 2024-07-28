# compiler.rb

 class Compiler.rb
  def initialize(input)
    @lexer = Lexer.new(input)
    @parser = Parser.new(@lexer.tokenize)
    @semantic_analyzer = SemanticAnalyzer.new(@parser.parse)
    @code_generator = CodeGenerator.new(@semantic_analyzer.analyze)
  end

  def compile
    @code_generator.generate_code
  end
end

# Example usage
input = "..." # Input source code in the Funky language
compiler = FunkyCompiler.new(input)
ruby_code = compiler.compile
puts ruby_code

compiler = Compiler.new(@ast)


end
