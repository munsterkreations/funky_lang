# semantic_analyzer.rb
class SemanticAnalyzer
  def initialize(parsed_code)
    @parsed_code = parsed_code
    @symbol_table = {}  # Symbol table to store variable and function definitions
  end

  def analyze
    @parsed_code.each do |statement|
      case statement[:type]
      when :function_definition
        analyze_function_definition(statement)
      when :assignment
        analyze_assignment(statement)
      when :conditional
        analyze_conditional(statement)
      when :loop
        analyze_loop(statement)
      end
    end
  end

  private

  def analyze_function_definition(statement)
    identifier = statement[:identifier]
    if @symbol_table.key?(identifier)
      raise_error("Function '#{identifier}' redefinition")
    else
      @symbol_table[identifier] = :function
    end
  end

  def analyze_assignment(statement)
    identifier = statement[:identifier]
    unless @symbol_table.key?(identifier)
      raise_error("Variable '#{identifier}' used before definition")
    end
  end

  def analyze_conditional(statement)
    analyze_expressions(statement[:condition])
    statement[:statements].each { |s| analyze_statement(s) }
    statement[:else_statements].each { |s| analyze_statement(s) } if statement[:else_statements]
  end

  def analyze_loop(statement)
    analyze_expressions(statement[:condition])
    statement[:statements].each { |s| analyze_statement(s) }
  end

  def analyze_statement(statement)
    case statement[:type]
    when :assignment
      analyze_assignment(statement)
    when :conditional
      analyze_conditional(statement)
    when :loop
      analyze_loop(statement)
    end
  end

  def analyze_expressions(expression)
    # Placeholder for expression semantic analysis logic
    # This method would typically check types, verify variable/function references, etc.
  end

  def raise_error(message)
    raise StandardError, message
  end
end
