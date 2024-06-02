require_relative 'maquina-turing-universal'
require_relative 'MT-MultiplicacaoCodificada'

entrada = linker + "#" + codificacao_cadeia
mt = MTU.new

puts "Entrada:\n#{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n#{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""
