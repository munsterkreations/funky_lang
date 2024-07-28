def parse_condition():
    condition_tokens = []
    while !eof? && !match?("colon")
      condition_tokens << consume_token_of_type("condition")
    end
    condition_tokens.join(" ")
  end