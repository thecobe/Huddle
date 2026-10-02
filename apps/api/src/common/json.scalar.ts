import { GraphQLScalarType, Kind, type ValueNode } from 'graphql';

function parseLiteral(ast: ValueNode): unknown {
  switch (ast.kind) {
    case Kind.STRING:
    case Kind.BOOLEAN:
      return ast.value;
    case Kind.INT:
    case Kind.FLOAT:
      return Number(ast.value);
    case Kind.OBJECT:
      return Object.fromEntries(ast.fields.map((f) => [f.name.value, parseLiteral(f.value)]));
    case Kind.LIST:
      return ast.values.map(parseLiteral);
    default:
      return null;
  }
}

export const GraphQLJSON = new GraphQLScalarType({
  name: 'JSON',
  description: 'Valore JSON arbitrario',
  serialize: (v) => v,
  parseValue: (v) => v,
  parseLiteral,
});
