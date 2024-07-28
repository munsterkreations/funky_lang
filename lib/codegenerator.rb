class FunkyLangCodeGenerator
    def initialize(ast)
      @ast = ast
    end
  
    def generate_statement
      #implement statement generation logic
      generate_statements(@ast)
    end
  
    private
  
    def generate_statements(statements)
      statements.map { |statement| generate_statement(statement) }.join("\n")
    end
  
    def generate_statement(statement)
      case statement.keys.first
      when :assignment
        "#{statement[:assignment][:identifier]} = #{generate_expression(statement[:assignment][:value])}"
      when :conditional
        generate_conditional(statement[:conditional])
      when :loop
        generate_loop(statement[:loop])
      when :for_loop
        generate_for_loop(statement[:for_loop])
      when :try_catch_block
        generate_try_catch_block(statement[:try_catch_block])
      when :print_statement
        "puts #{generate_expression(statement[:print_statement])}"
      else
        raise "Unknown statement type: #{statement.keys.first}"
      end
    end
  
    def generate_expression(expression)
      expression.is_a?(Hash) ? expression[:value] : expression
    end
  
    def generate_conditional(conditional)
      condition = "#{generate_expression(conditional[:condition][:operand1])} #{conditional[:condition][:operator]} #{generate_expression(conditional[:condition][:operand2])}"
      true_statements = generate_statements(conditional[:true_statements])
      false_statements = generate_statements(conditional[:false_statements]) if conditional[:false_statements]
      "if #{condition}\n#{true_statements}\nelse\n#{false_statements}\nend"
    end
  
    def generate_loop(loop)
      condition = "#{generate_expression(loop[:condition][:operand1])} #{loop[:condition][:operator]} #{generate_expression(loop[:condition][:operand2])}"
      body = generate_statements(loop[:body])
      "while #{condition}\n#{body}\nend"
    end
  
    def generate_for_loop(for_loop)
      initialization = generate_statement(for_loop[:initialization])
      condition = "#{generate_expression(for_loop[:condition][:operand1])} #{for_loop[:condition][:operator]} #{generate_expression(for_loop[:condition][:operand2])}"
      update = generate_statement(for_loop[:update])
      body = generate_statements(for_loop[:body])
      "#{initialization}\nwhile #{condition}\n#{body}\n#{update}\nend"
    end
  
    def generate_try_catch_block(try_catch_block)
      try_statements = generate_statements(try_catch_block[:try_statements])
      error_identifier = try_catch_block[:error_identifier]
      catch_statements = generate_statements(try_catch_block[:catch_statements])
      "begin\n#{try_statements}\nrescue => #{error_identifier}\n#{catch_statements}\nend"
    end
  end
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