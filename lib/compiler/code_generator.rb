class CodeGenerator
  def initialize(ast)
    @ast = ast
  end

  def generate_code
    # Implement code generation logic
    compiler = Compiler.new(@ast)
class Compiler
  def initialize(parsed_code)
    @parsed_code = parsed_code
    @indentation_level = 0
  end

  def compile
    @ruby_code = "funky_lang"
    @parsed_code.each do |statement|
      case statement[:type]
      when :function_definition
        compile_function_definition(statement)
      when :assignment
        compile_assignment(statement)
      when :conditional
        compile_conditional(statement)
      when :loop
        compile_loop(statement)
      else
        raise_error("Unsupported statement type: #{statement[:type]}")
      end
    end
    @ruby_code
  end

  private

  def compile_function_definition(statement)
    function_name = statement[:identifier]
    @ruby_code << "def #{function_name}()\n"
    @indentation_level += 1
    statement[:statements].each do |inner_statement|
      compile_statement(inner_statement)
    end
    @indentation_level -= 1
    @ruby_code << "end\n\n"
  end

  def compile_assignment(statement)
    variable_name = statement[:identifier]
    value = statement[:value]
    @ruby_code << "#{variable_name} = #{value}\n"
  end

  def compile_conditional(statement)
    condition = statement[:condition]
    @ruby_code << "if #{condition}\n"
    @indentation_level += 1
    statement[:statements].each do |inner_statement|
      compile_statement(inner_statement)
    end
    if statement[:else_statements]
      @ruby_code << "else\n"
      statement[:else_statements].each do |inner_statement|
        compile_statement(inner_statement)
      end
    end
    @indentation_level -= 1
    @ruby_code << "end\n"
  end

  def compile_loop(statement)
    condition = statement[:condition]
    @ruby_code << "while #{condition}\n"
    @indentation_level += 1
    statement[:statements].each do |inner_statement|
      compile_statement(inner_statement)
    end
    @indentation_level -= 1
    @ruby_code << "end\n"
  end

  def compile_statement(statement)
    case statement[:type]
    when :assignment
      compile_assignment(statement)
    when :conditional
      compile_conditional(statement)
    when :loop
      compile_loop(statement)
    else
      raise_error("Unsupported statement type: #{statement[:type]}")
    end
  end

  def raise_error(message)
    raise StandardError, message
  end
end
