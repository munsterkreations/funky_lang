# funky_compiler.rb

class Compiler
 require_relative 'funky_parser'

class Compiler
  def initialize(source_code)
    @source_code = source_code
  end

  def compile
    # Parse the source code using the FunkyParser
    parser = FunkyParser.new(@source_code)
    parsed_code = parser.parse

    # Generate Ruby code from the parsed code
    ruby_code = generate_ruby_code(parsed_code)

    ruby_code
  end

  private

  def generate_ruby_code(parsed_code)
    # Start with an empty string to accumulate the generated Ruby code
    ruby_code = ""

    # Iterate over each statement in the parsed code
    parsed_code.each do |statement|
      case statement[:type]
      when :assignment
        # Generate Ruby code for assignment statement
        ruby_code << generate_assignment_code(statement[:identifier], statement[:value])
      when :conditional
        # Generate Ruby code for conditional statement
        ruby_code << generate_conditional_code(statement[:conditions], statement[:statements])
      when :loop
        # Generate Ruby code for loop statement
        ruby_code << generate_loop_code(statement[:condition], statement[:statement])
      else
        # Handle expression or other types of statements
        # You can add code generation logic for additional statement types here
      end
    end

    ruby_code
  end

  def generate_assignment_code(identifier, value)
    # Generate Ruby code for assignment statement
    "#{identifier} = #{value}\n"
  end

  def generate_conditional_code(conditions, statements)
    # Generate Ruby code for conditional statement
    conditional_code = "if #{conditions.first}\n"
    statements.each do |statement|
      conditional_code << "  #{statement}\n"
    end
    conditional_code << "end\n"

    conditional_code
  end

  def generate_loop_code(condition, statement)
    # Generate Ruby code for loop statement
    loop_code = "while #{condition}\n"
    loop_code << "  #{statement}\n"
    loop_code << "end\n"

    loop_code
  end
end
