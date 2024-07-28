class Parser
  def initialize(tokens)
    @tokens = tokens
    @current_token_index = 0
  end

  def parse
  class FunkyParser
  def initialize(tokens)
    @tokens = tokens
    @current_token_index = 0
  end

  def parse
    program_statements = []
    while @current_token_index < @tokens.length
      program_statements << statement
    end
    program_statements
  end

  private

  def statement
    token = @tokens[@current_token_index]
    case token[:type]
    when "function"
      funky_definition
    when "identifier"
      case token[:value]
      when "can"
        conditional
      when "if cant"
        conditional_statements
      when "else"
        conditional
      when "during"
        loop
      else
        assignment
      end
    else
      expression
    end
  end

  def funky_definition
    consume("function") # Consume "funky"
    identifier = consume("identifier")
    consume(":")
    statements = []
    while match?("identifier") # Parse statements inside the function
      statements << statement
    end
    consume("funkend")
    { type: :function_definition, identifier: identifier, statements: statements }
  end

  def assignment
    identifier = consume("identifier")
    consume("is")
    value = expression
    { type: :assignment, identifier: identifier, value: value }
  end

  def conditional
    consume("can")
    condition = expression
    consume(":")
    statements = []
    while match?("identifier") # Parse statements inside the conditional
      statements << statement
    end
    consume("else") if match?("identifier") # Check for else part
    else_statements = []
    while match?("identifier") # Parse statements inside the else part
      else_statements << statement
    end
    { type: :conditional, condition: condition, statements: statements, else_statements: else_statements }
  end

  def loop
    consume("during")
    condition = expression
    consume(":")
    statements = []
    while match?("identifier") # Parse statements inside the loop
      statements << statement
    end
    { type: :loop, condition: condition, statements: statements }
  end

  def expression
    # Placeholder for expression parsing logic
    # For now, simply consume and return the value
    consume("identifier")[:value]
  end

  def consume(expected_token_type)
    if match?(expected_token_type)
      token = @tokens[@current_token_index]
      @current_token_index += 1
      token
    else
      raise_error("Expected #{expected_token_type}")
    end
  end

  def match?(expected_token_type)
    token = @tokens[@current_token_index]
    return false if token.nil?

    token[:type] == expected_token_type
  end

  def raise_error(message)
    raise StandardError, message
  end
end

  end
end
