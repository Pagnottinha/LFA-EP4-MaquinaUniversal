## estados não finais
## fa...
q0 = "fa"
q1 = "faa"
q2 = "faaa"
q3 = "faaaa"
q4 = "faaaaa"
q5 = "faaaaaa"
q6 = "faaaaaaa"
q7 = "faaaaaaaa"
q8 = "faaaaaaaaa"
q9 = "faaaaaaaaaa"
q10 = "faaaaaaaaaaa"

## estados finais
## fb...
qf = "fb"

# símbolo branco
@s = "_"

## elementos do alfabeto
## sigma = sc...
@a = "sc"
@b = "scc"
@c = "sccc"
@z = "scccc"

## movimentacao do cursor
esq = "e"
dir = "d"

# transição d(qi,sm) = (qj,sn,E)
@d1 = "#{q0}#{@s}#{q1}#{@s}#{dir}"
@d2 = "#{q1}#{@a}#{q1}#{@a}#{dir}"
@d3 = "#{q1}#{@b}#{q2}#{@z}#{dir}"
@d4 = "#{q2}#{@c}#{q2}#{@c}#{dir}"
@d5 = "#{q2}#{@b}#{q2}#{@b}#{dir}"
@d6 = "#{q2}#{@s}#{q3}#{@c}#{esq}"
@d7 = "#{q3}#{@c}#{q3}#{@c}#{esq}"
@d8 = "#{q3}#{@b}#{q4}#{@b}#{esq}"
@d9 = "#{q3}#{@z}#{q6}#{@b}#{esq}"
@d10 = "#{q4}#{@b}#{q4}#{@b}#{esq}"
@d11 = "#{q4}#{@z}#{q5}#{@z}#{dir}"
@d12 = "#{q5}#{@b}#{q2}#{@z}#{dir}"
@d13 = "#{q6}#{@z}#{q6}#{@b}#{esq}"
@d14 = "#{q6}#{@a}#{q7}#{@a}#{esq}"
@d15 = "#{q6}#{@s}#{q10}#{@s}#{dir}"
@d16 = "#{q7}#{@a}#{q7}#{@a}#{esq}"
@d17 = "#{q7}#{@s}#{q8}#{@s}#{dir}"
@d18 = "#{q8}#{@a}#{q9}#{@s}#{dir}"
@d19 = "#{q9}#{@a}#{q1}#{@a}#{dir}"
@d20 = "#{q9}#{@b}#{q10}#{@s}#{dir}"
@d21 = "#{q10}#{@b}#{q10}#{@s}#{dir}"
@d22 = "#{q10}#{@c}#{qf}#{@c}#{esq}"

def linker
  "#{@d1}#{@d2}#{@d3}#{@d4}#{@d5}#{@d6}#{@d7}#{@d8}#{@d9}#{@d10}#{@d11}#{@d12}#{@d13}#{@d14}#{@d15}#{@d16}#{@d17}#{@d18}#{@d19}#{@d20}#{@d21}#{@d22}"
end

def codificacao_cadeia
  "#{@s}#{@a}#{@a}#{@b}#{@b}#{@b}#{@s}"
end
