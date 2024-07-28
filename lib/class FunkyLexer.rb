class FunkyLexer
  KEYWORDS = {
    "funky" => :FUNCTION,
    "funkend" => :FUNCTION_END,
    "can" => :CAN,
    "if" => :IF,
    "cant" => :ELSE_IF,
    "else" => :ELSE,
    "during" => :DURING,
    "is" => :IS,
    "and" => :AND,
    "or" => :OR,
    "sum" => :SUM,
    "difference" => :DIFFERENCE,
    "product" => :PRODUCT,
    "quotient" => :QUOTIENT,
    "==" => :EQUALS,
    "!=" => :NOT_EQUALS,
    ">" => :GREATER_THAN,
    "<" => :LESS_THAN,
    ">=" => :GREATER_THAN_OR_EQUAL,
    "<=" => :LESS_THAN_OR_EQUAL,
    "=" => :ASSIGNMENT
  }

  def initialize(input)
    @input = input
    @position = 0
    @current_char = @input[@position]
  end

  def advance
    @position += 1
    @current_char = @input[@position]
  end

  def peek
    peek_position = @position + 1
    peek_position < @input.length ? @input[peek_position] : nil
  end

  def skip_whitespace
    advance while @current_char && @current_char.match(/\s/)
  end

  def skip_comment
    advance while @current_char && @current_char != "\n"
  end

  def number
    result = ""
    while @current_char && @current_char.match(/\d/)
      result += @current_char
      advance
    end
    if @current_char == '.'
      result += '.'
      advance
      while @current_char && @current_char.match(/\d/)
        result += @current_char
        advance
      end
    end
    result.include?('.') ? result.to_f : result.to_i
  end

  def string
    result = ""
    advance
    while @current_char && @current_char != '"'
      result += @current_char
      advance
    end
    advance
    result
  end

  def identifier
    result = ""
    while @current_char && @current_char.match(/[a-zA-Z_]/)
      result += @current_char
      advance
    end
    KEYWORDS[result] || :IDENTIFIER
  end

  def get_next_token
    while @current_char
      if @current_char.match(/\s/)
        skip_whitespace
        next
      end

      if @current_char == "#"
        skip_comment
        next
      end

      if @current_char.match(/\d/)
        return { type: :NUMBER, value: number }
      end

      if @current_char == '"'
        return { type: :STRING, value: string }
      end

      if @current_char.match(/[a-zA-Z_]/)
        id = identifier
        token_type = KEYWORDS[id] || :IDENTIFIER
        return { type: token_type, value: id }
      end

      case @current_char
      when "+"
        advance
        return { type: :PLUS, value: "+" }
      when "-"
        advance
        return { type: :MINUS, value: "-" }
      when "*"
        advance
        return { type: :MULTIPLY, value: "*" }
      when "/"
        advance
        return { type: :DIVIDE, value: "/" }
      when "("
        advance
        return { type: :LPAREN, value: "(" }
      when ")"
        advance
        return { type: :RPAREN, value: ")" }
      when ":"
        advance
        return { type: :COLON, value: ":" }
      when ","
        advance
        return { type: :COMMA, value: "," }
      when "="
        advance
        if @current_char == "="
          advance
          return { type: :EQUALS, value: "==" }
        else
          return { type: :ASSIGNMENT, value: "=" }
        end
      when ">"
        advance
        if @current_char == "="
          advance
          return { type: :GREATER_THAN_OR_EQUAL, value: ">=" }
        else
          return { type: :GREATER_THAN, value: ">" }
        end
      when "<"
        advance
        if @current_char == "="
          advance
          return { type: :LESS_THAN_OR_EQUAL, value: "<=" }
        else
          return { type: :LESS_THAN, value: "<" }
        end
      when "!"
        advance
        if @current_char == "="
          advance
          return { type: :NOT_EQUALS, value: "!=" }
        else
          raise "Invalid character '!'"
        end
      else
        raise "Invalid character '#{@current_char}'"
      end
    end

    { type: :EOF, value: nil }
  end
end
