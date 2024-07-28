class FunkyLangParser
    def initialize(tokens)
      @tokens = tokens
      @current_token = 0
    end
  
    def parse
      program
    end
  
    private
  
    def program
      statements = []
      while !eof?
        statements << statement
      end
      statements
    end
  
    def statement
      case current_token
      when 'vardec'
        variable_declaration
      when 'funky'
        function_definition
      if match?("identifier") && match?("is")
        assignment
      when 'if'
        conditional
      when 'for'
        for_loop
      when 'while'
        while_loop
      when 'try'
        try_catch_block
      when 'print'
        print_statement
      when '/'
        comment
      else
        raise_error("Unknown statement: #{current_token}")
        end
    end
  
    def variable_declaration
      consume('var')
      identifier = consume('identifier')
      consume('=')
      value = expression
      { variable_declaration: { identifier: identifier, value: value } }
    end
  
    def function_definition
      consume('function')
      name = consume('identifier')
      consume('(')
      parameters = []
      while current_token != ')'
        parameters << consume('identifier')
        consume(',') if current_token == ','
      end
      consume(')')
      consume('{')
      body = []
      while current_token != '}'
        body << statement
      end
      consume('}')
      { function_definition: { name: name, parameters: parameters, body: body } }
    end
  
    def conditional
      consume('if')
      condition = parse_condition
      consume('{')
      true_statements = []
      while current_token != '}'
        true_statements << statement
      end
      consume('}')
      false_statements = []
      if match?('else')
        consume('else')
        consume('{')
        while current_token != '}'
          false_statements << statement
        end
        consume('}')
      end
      { conditional: { condition: condition, true_statements: true_statements, false_statements: false_statements } }
    end
  
    def for_loop
      consume('for')
      initialization = statement
      condition = parse_condition
      update = statement
      consume('{')
      body = []
      while current_token != '}'
        body << statement
      end
      consume('}')
      { for_loop: { initialization: initialization, condition: condition, update: update, body: body } }
    end
  
    def while_loop
      consume('while')
      condition = parse_condition
      consume('{')
      body = []
      while current_token != '}'
        body << statement
      end
      consume('}')
      { while_loop: { condition: condition, body: body } }
    end
  
    def try_catch_block
      consume('try')
      consume('{')
      try_statements = []
      while current_token != '}'
        try_statements << statement
      end
      consume('}')
      consume('catch')
      consume('identifier')
      consume('{')
      catch_statements = []
      while current_token != '}'
        catch_statements << statement
      end
      consume('}')
      { try_catch_block: { try_statements: try_statements, catch_statements: catch_statements } }
    end
  
    def print_statement
      consume('print')
      expression = expression()
      { print_statement: expression }
    end
  
    def comment
      if current_token.start_with?("//")
        consume('comment')
        { comment: current_token }
      elsif current_token == "/*"
        multi_line_comment
      else
        raise_error("Invalid comment syntax")
      end
    end
  
    def multi_line_comment
      consume('/*')
      comment = ""
      while current_token != '*/'
        comment << consume('comment')
      end
      consume('*/')
      { multi_line_comment: comment }
    end
  
    def parse_condition
      operand1 = expression
      operator = consume(['<', '>', '==', '!='])
      operand2 = expression
      { operand1: operand1, operator: operator, operand2: operand2 }
    end
  
    def expression
      if match?('number')
        consume('number').to_i
      elsif match?('identifier')
        consume('identifier')
      elsif match?('string')
        consume('string')
      elsif match?('boolean')
        consume('boolean')
      else
        raise_error("Invalid expression")
      end
    end
  
    def consume(expected_token_type)
      if match?(expected_token_type)
        token = @tokens[@current_token]
        @current_token += 1
        token[:value]
      else
        raise_error("Expected #{expected_token_type}")
      end
    end
  
    def match?(expected_token_type)
      !eof? && @tokens[@current_token][:type] == expected_token_type
    end
  
    def current_token
      @tokens[@current_token][:value]
    end
  
    def eof?
      @current_token >= @tokens.length
    end
  
    def raise_error(message)
      raise "Parse Error: #{message}"
    end
  end
  
  # Example usage with tokens
  tokens = [
    { type: 'var', value: 'var' },
    { type: 'identifier', value: 'x' },
    { type: 'is', value: 'is' },
    { type: 'number', value: '10' }
    # More tokens for the rest of the code
  ]
  
  parser = FunkyLangParser.new(tokens)
  parsed_code = parser.parse
  puts parsed_code
  