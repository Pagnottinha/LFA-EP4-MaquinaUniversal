# Linguagem Livre de Contexto: a^n b^n

# Estados não finais
q0 = "fa"
q1 = "faa"
q2 = "faaa"
q3 = "faaaa"

# Estado final
q4 = "fb"

# Símbolo branco
@b = "_"

# Elementos do alfabeto
@x = "sc"  # a
@y = "scc"  # b

# Movimentação do cursor
esq = "e"
dir = "d"

# Transições
@d1 = "#{q0}#{@x}#{q1}#{@b}#{dir}"
@d2 = "#{q1}#{@x}#{q1}#{@x}#{dir}"
@d3 = "#{q1}#{@y}#{q1}#{@y}#{dir}"
@d4 = "#{q1}#{@b}#{q2}#{@b}#{esq}"
@d5 = "#{q2}#{@y}#{q3}#{@b}#{esq}"
@d6 = "#{q3}#{@y}#{q3}#{@y}#{esq}"
@d7 = "#{q3}#{@x}#{q3}#{@x}#{esq}"
@d8 = "#{q3}#{@b}#{q0}#{@b}#{dir}"
@d9 = "#{q2}#{@b}#{q4}#{@b}#{dir}"
@d10 = "#{q0}#{@b}#{q4}#{@b}#{dir}"

def linker
  "#{@d1}#{@d2}#{@d3}#{@d4}#{@d5}#{@d6}#{@d7}#{@d8}#{@d9}#{@d10}"
end

def codificacao_cadeia
  "#{@x}#{@x}#{@y}#{@y}#{@b}"
end