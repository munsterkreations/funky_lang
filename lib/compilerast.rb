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
      if match?('identifier') && lookahead('is')
        assignment
      elsif match?('if')
        conditional
      elsif match?('while')
        loop
      elsif match?('for')
        for_loop
      elsif match?('try')
        try_catch_block
      elsif match?('print')
        print_statement
      else
        raise_error('Unknown statement')
      end
    end
  
    def assignment
      identifier = consume('identifier')
      consume('is')
      value = expression
      { assignment: { identifier: identifier, value: value } }
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
        raise_error('Invalid expression')
      end
    end
  
    def conditional
      consume('if')
      condition = parse_condition
      consume('{')
      true_statements = []
      while !match?('}')
        true_statements << statement
      end
      consume('}')
      false_statements = []
      if match?('else')
        consume('else')
        consume('{')
        while !match?('}')
          false_statements << statement
        end
        consume('}')
      end
      { conditional: { condition: condition, true_statements: true_statements, false_statements: false_statements } }
    end
  
    def loop
      consume('while')
      condition = parse_condition
      consume('{')
      body = []
      while !match?('}')
        body << statement
      end
      consume('}')
      { loop: { condition: condition, body: body } }
    end
  
    def for_loop
      consume('for')
      initialization = assignment
      consume(';')
      condition = parse_condition
      consume(';')
      update = assignment
      consume('{')
      body = []
      while !match?('}')
        body << statement
      end
      consume('}')
      { for_loop: { initialization: initialization, condition: condition, update: update, body: body } }
    end
  
    def try_catch_block
      consume('try')
      consume('{')
      try_statements = []
      while !match?('}')
        try_statements << statement
      end
      consume('}')
      consume('catch')
      error_identifier = consume('identifier')
      consume('{')
      catch_statements = []
      while !match?('}')
        catch_statements << statement
      end
      consume('}')
      { try_catch_block: { try_statements: try_statements, error_identifier: error_identifier, catch_statements: catch_statements } }
    end
  
    def print_statement
      consume('print')
      value = expression
      { print_statement: value }
    end
  
    def parse_condition
      operand1 = expression
      operator = consume('comparison')
      operand2 = expression
      { operand1: operand1, operator: operator, operand2: operand2 }
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
      !eof? && current_token_type == expected_token_type
    end
  
    def lookahead(expected_token_type)
      @tokens[@current_token + 1][:type] == expected_token_type if @current_token + 1 < @tokens.length
    end
  
    def current_token_type
      @tokens[@current_token][:type]
    end
  
    def eof?
      @current_token >= @tokens.length
    end
  
    def raise_error(message)
      raise "Parse Error: #{message}"
    end
  end
  