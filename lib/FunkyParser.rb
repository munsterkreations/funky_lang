class FunkyParser
    attr_reader :tokens
  
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
      if match?("identifier") && match?("is")
        assignment
      elsif match?("if")
        conditional
      elsif match?("while")
        loop
      else
        expression
      end
    end
  
    def assignment
      identifier = consume_identifier
      consume_symbol("is")
      value = expression
      { identifier: identifier, value: value }
    end
  
    def consume_identifier
      consume_token_of_type("identifier")
    end
  
    def consume_symbol(value)
      consume_token_of_type("symbol", value)
    end
  
    def consume_token_of_type(type, value = nil)
      token = tokens[current_token]
      raise_error("Expected #{type}") unless token[:type] == type && token[:value] == value
      @current_token += 1
      token[:value]
    end
  
    def expression
      if match?("number")
        consume("number").to_i
      else
        operation
      end
    end
  
    def operation
      case consume("operation")
      when "sum"
        consume("of")
        operand1 = expression
        consume("and")
        operand2 = expression
        { operation: "sum", operand1: operand1, operand2: operand2 }
      # Handle other operation types here
      else
        raise_error("Invalid operation")
      end
    end
  
    def conditional
      consume("if")
      condition = parse_condition
      consume(":")
      statement = statement
      { condition: condition, statement: statement }
    end
  
    def loop
      consume("while")
      condition = parse_condition
      consume(":")
      statement = statement
      { condition: condition, statement: statement }
    end
  
    def parse_condition
      # Implement parsing of conditions here
    end
  
    def eof?
      current_token >= tokens.length
    end
  
    def consume(type)
      token = tokens[current_token]
      raise_error("Expected #{type}") unless token[:type] == type
      @current_token += 1
      token[:value]
    end
  
    def match?(type)
      tokens[current_token][:type] == type
    end
  
    def raise_error(message)
      raise message
    end
  end
  