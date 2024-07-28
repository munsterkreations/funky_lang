funky_lang=(
tokens = [
  { type: 'identifier', value: 'x' },
 
  { type: 'is', value: 'is' },
 
  { type: 'number', value: '10' },
 
  { type: 'identifier', value: 'y' },
 
  { type: 'is', value: 'is' },
 
  { type: 'number', value: '20' },
 
  { type: 'if', value: 'if' },
 
  { type: 'identifier', value: 'x' },
 
  { type: '>', value: '>' },
 
  { type: 'number', value: '5' },
 
  { type: '{', value: '{' },
 
  { type: 'print', value: 'print' },
 
  { type: 'string', value: '"x is greater than 5"' },
 
  { type: '}', value: '}' },
 
  { type: 'else', value: 'else' },
 
  { type: '{', value: '{' },
 
  { type: 'print', value: 'print' },
 
  { type: 'string', value: '"x is not greater than 5"' },
 
  { type: '}', value: '}' },
 
  { type: 'while', value: 'while' },
 
  { type: 'identifier', value: 'y' },
 
  { type: '>', value: '>' },
 
  { type: 'number', value: '0' },
 
  { type: '{', value: '{' },
 
  { type: 'print', value: 'print' },
 
  { type: 'identifier', value: 'y' },
 
  { type: 'identifier', value: 'y' },
 
  { type: 'is', value: 'is' },
 
  { type: 'identifier', value: 'y' },
 
  { type: '-', value: '-' },
 
  { type: 'number', value: '1' },
 
  { type: '}', value: '}' },
 
  { type: 'for', value: 'for' },
 
  { type: 'identifier', value: 'i' },
 
  { type: 'is', value: 'is' },
 
  { type: 'number', value: '0' },
 
  { type: ';', value: ';' },
 
  { type: 'identifier', value: 'i' },
 
  { type: '<', value: '<' },
 
  { type: 'number', value: '5' },
 
  { type: ';', value: ';' },
 
  { type: 'identifier', value: 'i' },
 
  { type: 'is', value: 'is' },
 
  { type: 'identifier', value: 'i' },
 
  { type: '+', value: '+' },
 
  { type: 'number', value: '1' },
 
  { type: '{', value: '{' },
 
  { type: 'print', value: 'print' },
 
  { type: 'identifier', value: 'i' },
 
  { type: '}', value: '}' },
 
  { type: 'try', value: 'try' },
 
  { type: '{', value: '{' },
 
  { type: 'print', value: 'print' },
 
  { type: 'string', value: '"Trying something risky"' },
 
  { type: '}', value: '}' },
 
  { type: 'catch', value: 'catch' },
 
  { type: 'identifier', value: 'error' },
 
  { type: '{', value: '{' },
 
  { type: 'print', value: 'print' },
 
  { type: 'string', value: '"Caught an error!"' },
 
  { type: '}', value: '}' },
 
  { type: 'print', value: 'print' },
 
  { type: 'string', value: '"Get, funky!"' },
]
)

parser = FunkyLangParser.new(tokens)
parsed_code = parser.parse
puts parsed_code
