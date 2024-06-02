class TuringMachine

  def initialize
    @estado = :q0
    @cursor = 0
  end

  def processar(entrada)
    @fita = "_" + entrada + "_"*20
    @estado = :q0
    @cursor = 0

    while true
      case [@estado, @fita[@cursor]]
      in [:q0, "_"]
        operar("_", :q1, :D)
      in [:q1, "a"]
        operar("a", :q1, :D)
      in [:q1, "b"]
        operar("z", :q2, :D)
      in [:q2, s] if ["b", "c"].include?(s)
        operar(s, :q2, :D)
      in [:q2, "_"]
        operar("c", :q3, :E)
      in [:q3, "c"]
        operar("c", :q3, :E)
      in [:q3, "b"]
        operar("b", :q4, :E)
      in [:q3, "z"]
        operar("b", :q6, :E)
      in [:q4, "b"]
        operar("b", :q4, :E)
      in [:q4, "z"]
        operar("z", :q5, :D)
      in [:q5, "b"]
        operar("z", :q2, :D)
      in [:q6, "z"]
        operar("b", :q6, :E)
      in [:q6, "a"]
        operar("a", :q7, :E)
      in [:q6, "_"]
        operar("_", :q10, :D)
      in [:q7, "a"]
        operar("a", :q7, :E)
      in [:q7, "_"]
        operar("_", :q8, :D)
      in [:q8, "a"]
        operar("_", :q9, :D)
      in [:q9, "a"]
        operar("a", :q1, :D)
      in [:q9, "b"]
        operar("_", :q10, :D)
      in [:q10, "b"]
        operar("_", :q10, :D)
      in [:q10, "c"]
        operar("c", :qf, :E)
      in [:qf, _]
        return true
      else
        return false
      end
    end
  end

  def operar(escrever, estado, movimento = :D)
    @fita[@cursor] = escrever
    @estado = estado
    if movimento == :D
      @cursor += 1
    else
      @cursor -= 1
    end
  end

  def fita
    @fita
  end

  def cursor
    @cursor
  end

  def estado
    @estado
  end
end

input = "aabbbb"
tm = TuringMachine.new
puts "Entrada: #{input}"
puts "Aceito? #{tm.processar(input)}"
puts "Fita #{tm.fita}"
puts "Cursor #{tm.cursor}"
puts "Estado #{tm.estado}"
