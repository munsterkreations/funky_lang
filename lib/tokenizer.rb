class FunkyLangTokenizer
    TOKEN_PATTERNS = {
      'if' => /\bif\b/,
      'else' => /\belse\b/,
      'while' => /\bwhile\b/,
      'for' => /\bfor\b/,
      'try' => /\btry\b/,
      'catch' => /\bcatch\b/,
      'print' => /\bprint\b/,
      'identifier' => /\b[a-zA-Z_][a-zA-Z0-9_]*\b/,
      'number' => /\b\d+\b/,
      'string' => /"[^"]*"/,
      'is' => /\bis\b/,
      'operator' => /[+\-*/]/,
      'comparison' => /[<>]=?|==|!=/,
      'punctuation' => /[{}();]/
    }
  
    def initialize(source_code)
      @source_code = source_code
      @tokens = []
      @current_position = 0
    end
  
    def tokenize
      while @current_position < @source_code.length
        TOKEN_PATTERNS.each do |type, pattern|
          match = match_pattern(pattern)
          if match
            @tokens << { type: type, value: match }
            break
          end
        end
        @current_position += 1 if match.nil?
      end
      @tokens
    end
  
    private
  
    def match_pattern(pattern)
      @source_code[@current_position..].match(/\A#{pattern}/)&.to_s
    end
  end
  