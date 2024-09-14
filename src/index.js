const nearley = require("nearley")
const grammar = require("./parse/grammar.js")

const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar))

parser.feed('<SAY "Hello world" 5>')

console.log(JSON.stringify(parser.results[0]))