@builtin "number.ne"
@builtin "string.ne"
@builtin "whitespace.ne"

File -> (List | Structure {%d=>d[0]%}):+ {%d=>d[0]%}

List                                -> PARENTHESIS_OPEN _ Values _ PARENTHESIS_CLOSE        {% (d=>{return [d[2].flat()]}) %}
                                       | PARENTHESIS_OPEN _ PARENTHESIS_CLOSE               {% (d=>{return []}) %}
Structure                           -> ABRACKET_OPEN _ Structure_Body _ ABRACKET_CLOSE      {% (d=>{return d[2]}) %}

Structure_Body                      -> Word (__ Values {%d=>d[1]%}):?                       {% (d=>{return {name: d[0], body: d[1]}}) %}

# Symbols (Groups: Values)

Values                              -> Value (__ Value {% d=>d[1] %}):*                     {% d=>d.flat(1) %}

Value                               -> Int | String | Keyword | Word | Structure | List   {% id %}

# Symbols (Words)

Argument                            -> DOT Word                             {% (d=>{return {type: "argument", value: d[1]}}) %}
Pointer                             -> AT Word                              {% (d=>{return {type: "pointer", value: d[1]}}) %}
Reference                           -> COMMA Word                           {% (d=>{return {type: "referece", value: d[1]}}) %}
Keyword                             -> APOSTROPHE Word                      {% (d=>{return {type: "keyword", value: d[1]}}) %}
String                              -> dqstring                             {% (d=>{return {type: "string", value: d[1]}}) %}
Int                                 -> int                                  {% (d=>{return {type: "int", value: d[1]}}) %}

Word                                -> [a-zA-Z-]:+                       {% (d=>{return d.flat().join('')}) %}

# Symbols (Characters)

ABRACKET_CLOSE                      -> ">" {% id %} 
ABRACKET_OPEN                       -> "<" {% id %}
APOSTROPHE                          -> "'" {% id %}
AT                                  -> "@" {% id %} 
COMMA                               -> "," {% id %}
DOT                                 -> "." {% id %} 
PARENTHESIS_CLOSE                   -> ")" {% id %} 
PARENTHESIS_OPEN                    -> "(" {% id %}
SEMICOLON                           -> ";" {% id %} 