# Linguagem Sensível ao Contexto: a^n b^n c^n
# Estados não finais 
q0 = "fa"
q1 = "faa"
q2 = "faaa"
q3 = "faaaa"
q4 = "faaaaa"
q5 = "faaaaaa"

# Estados finais
q6 = "fb"

# Símbolo branco
@b = "_"

# Elementos do alfabeto
@x  = "sc" 
@y  = "scc" 
@z  = "sccc" 

# Substituição de: 'a', 'b', 'c'
@A  = "scccc"
@B  = "sccccc"
@C  = "scccccc"

# Movimentação do cursor
esq = "e"
dir = "d"

# Transições
@d1 = "#{q0}#{@x}#{q1}#{@A}#{dir}"
@d2 = "#{q1}#{@x}#{q1}#{@x}#{dir}"
@d3 = "#{q1}#{@B}#{q1}#{@B}#{dir}"
@d4 = "#{q1}#{@y}#{q2}#{@B}#{dir}"
@d5 = "#{q2}#{@y}#{q2}#{@y}#{dir}"
@d6 = "#{q2}#{@C}#{q2}#{@C}#{dir}"
@d7 = "#{q2}#{@z}#{q3}#{@C}#{esq}"
@d8 = "#{q3}#{@C}#{q3}#{@C}#{esq}"
@d9 = "#{q3}#{@y}#{q3}#{@y}#{esq}"
@d10 = "#{q3}#{@B}#{q3}#{@B}#{esq}"
@d11 = "#{q3}#{@x}#{q3}#{@x}#{esq}"
@d12 = "#{q3}#{@A}#{q0}#{@A}#{dir}"
@d13 = "#{q0}#{@B}#{q4}#{@B}#{dir}"
@d14 = "#{q4}#{@B}#{q4}#{@B}#{dir}"
@d15 = "#{q4}#{@C}#{q5}#{@C}#{dir}"
@d16 = "#{q5}#{@C}#{q5}#{@C}#{dir}"
@d17 = "#{q5}#{@b}#{q6}#{@b}#{dir}"

# Função que retorna todas as transições concatenadas
def linker 
  "#{@d1}#{@d2}#{@d3}#{@d4}#{@d5}#{@d6}#{@d7}#{@d8}#{@d9}#{@d10}#{@d11}#{@d12}#{@d13}#{@d14}#{@d15}#{@d16}#{@d17}"
end

# Função que codifica a cadeia de entrada
def codificacao_cadeia
  "#{@x}#{@x}#{@y}#{@y}#{@z}#{@z}#{@b}"
end