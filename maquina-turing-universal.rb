class MTU
  attr_accessor :fita, :estado, :cursor, :estado_leitura, :simbolo_leitura, :estado_destino, :simbolo_escrita, :movimento, :transicoes

  def initialize
    @estado = :qi
    @cursor = 0
    @movimento_salvo = :D
  end

  def processar(entrada)
    @fita = "$" + entrada + "_" * entrada.size * 3 + " " # fita semi-infinita, virtual
    estado_leitura = ""
    simbolo_leitura = ""
    estado_destino = ""
    simbolo_escrita = ""
    movimento = :D
    transicoes = {}
    @fita_cadeia = []

    while true
      case [@estado, @fita[@cursor]]

      # iniciar máquina em qi e ir para primeiro estado
      in [:qi, "$"]
        operar("$", :q0, :D)
      # começa a ler a fita e salva em uma estrutura de memória.
      # neste caso, vamos salvar em uma estrutura do Ruby
      # fa... -> não terminal
      # fb... -> terminal
      in [:q0, "f"] # começo de estado
        estado_leitura << "f"
        operar("f", :q0b, :D)
      in [:q0b, "a"] # estado não terminal
        estado_leitura << "a"
        operar("a", :q1, :D)
      in [:q1, "a"] # estado não terminal
        estado_leitura << "a"
        operar("a", :q1, :D)
      in [:q1, "s"] # estado não terminal para simbolo
        simbolo_leitura << "s"
        operar("s", :q3, :D)
      in [:q1, "_"]
        simbolo_leitura << "_"
        operar("_", :q3b, :D)
      in [:q0b, "b"] # estado terminal
        estado_leitura << "b"
        operar("b", :q2, :D)
      in [:q2, "b"] # estado terminal
        estado_leitura << "b"
        operar("b", :q2, :D)
      in [:q2, "s"] # estado terminal para simbolo
        simbolo_leitura << "s"
        operar("s", :q3, :D)
      in [:q2, "_"]
        simbolo_leitura << "_"
        operar("_", :q3b, :D)

      ## Leitura de símbolo de leitura
      in [:q3, "c"] # leitura de símbolos
        simbolo_leitura << "c"
        operar("c", :q3, :D)
      in [:q3, "f"] # acabou leitura de símbolos
        estado_destino << "f"
        operar("f", :q4, :D)
      in [:q3b, "f"] # depois de ler espaço em branco
        estado_destino << "f"
        operar("f", :q4, :D)

      # leitura de estado de destino
      in [:q4, "a"] # estado não terminal
        estado_destino << "a"
        operar("a", :q5, :D)
      in [:q5, "a"] # estado não terminal
        estado_destino << "a"
        operar("a", :q5, :D)
      in [:q5, "s"] # estado não terminal para simbolo
        simbolo_escrita << "s"
        operar("s", :q7, :D)
      in [:q5, "_"] # estado não terminal para simbolo branco
        simbolo_escrita << "_"
        operar("_", :q7b, :D)
      in [:q4, "b"] # estado terminal
        estado_destino << "b"
        operar("b", :q6, :D)
      in [:q6, "b"] # estado terminal
        estado_destino << "b"
        operar("b", :q6, :D)
      in [:q6, "s"] # estado terminal para simbolo
        simbolo_escrita << "s"
        operar("s", :q7, :D)
      in [:q6, "_"] # estado não terminal para simbolo branco
        simbolo_escrita << "_"
        operar("_", :q7b, :D)

      # leitura de símbolo de escrita
      in [:q7, "c"] # leitura de símbolos
        simbolo_escrita << "c"
        operar("c", :q7, :D)
      in [:q7, "d"] # acabou leitura de símbolos + leitura de movimento (direita)
        movimento = :D
        operar("d", :q8, :D)
      in [:q7, "e"] # acabou leitura de símbolos + leitura de movimento (esquerda)
        movimento = :E
        operar("e", :q8, :D)

      in [:q7b, "d"] # acabou leitura de símbolos + leitura de movimento (direita)
        movimento = :D
        operar("d", :q8, :D)
      in [:q7b, "e"] # acabou leitura de símbolos + leitura de movimento (esquerda)
        movimento = :E
        operar("e", :q8, :D)

      # reinicia a máquina
      in [:q8, "f"]
        # direta, salva transição
        leitura = [estado_leitura, simbolo_leitura]
        transicoes[leitura] = [simbolo_escrita, estado_destino, movimento]
        puts("Transição lida: (#{estado_leitura},#{simbolo_leitura})->(#{simbolo_escrita},#{estado_destino},#{movimento})")

        estado_leitura = "f"
        simbolo_leitura = ""
        estado_destino = ""
        simbolo_escrita = ""

        operar("f", :q0b, :D)

      ######### leitura dos símbolos de w ##########
      # começa a leitura dos símbolos e processamento de w
      in [:q8, "#"]
        # adiciona o último estado
        leitura = [estado_leitura, simbolo_leitura]
        transicoes[leitura] = [simbolo_escrita, estado_destino, movimento]
        puts("Transição lida: (#{estado_leitura},#{simbolo_leitura})->(#{simbolo_escrita},#{estado_destino},#{movimento})")

        puts("==========================================\n\n")
        puts("=========== Leitura dos símbolos: ===========")

        operar("#", :q9, :D)
        simbolo_leitura = ""
      in [:q9, "_"]
        @fita_cadeia << "_"
        simbolo_leitura = ""
        operar("_", :q9, :D)
      in [:q9, "s"]
        simbolo_leitura << "s"
        operar("s", :q10, :D)
      in [:q10, "c"]
        simbolo_leitura << "c"
        operar("c", :q10, :D)

      in [:q10, "s"] # recomeça a leitura
        @fita_cadeia << simbolo_leitura
        simbolo_leitura = "s"
        operar("s", :q10, :D)

      in [:q10, "_"]
        @fita_cadeia << simbolo_leitura
        @fita_cadeia << "_"
        simbolo_leitura = ""
        operar("_", :q9, :D)

      in [:q9 | :q10, " "] # finaliza leitura
        puts("=========== Fita de símbolos: ===========\n")
        print(@fita_cadeia)
        ######## iniciando a leitura de w
        return submaquina(transicoes)
      else
        puts "(#{estado_leitura},#{simbolo_leitura}) = (#{estado_destino},#{simbolo_escrita},#{movimento})"
        return false
      end
    end
  end

  def submaquina(transicoes)
    # estado inicial da máquina a ser simulada
    estado_mt = "fa"
    @cursor_leitura = 0

    while true
      simbolo_leitura = @fita_cadeia[@cursor_leitura]

      leitura = [estado_mt, simbolo_leitura]
      puts "(#{estado_mt}, #{simbolo_leitura})"
      resultado = transicoes[leitura]

      if resultado == nil
        puts "\n=========================================="
        puts "Finalizando a leitura na máquina principal"
        puts "Estado final da máquina: #{estado_mt}"
        puts "==========================================\n\n"
        return false
      end

      simbolo_escrita = resultado[0]
      estado_destino = resultado[1]
      movimento = resultado[2]
      puts "-> (#{estado_destino},#{simbolo_escrita},#{movimento})"

      estado_mt = estado_destino
      @fita_cadeia[@cursor_leitura] = simbolo_escrita

      if (estado_destino.start_with?("fb")) # se é aceitação
        puts "\n=========================================="
        puts "Finalizando a leitura na máquina principal"
        puts "Estado final da máquina: #{estado_mt}"
        puts "==========================================\n\n"
        return true
      end

      if movimento == :D
        @cursor_leitura += 1
      else
        @cursor_leitura -= 1
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
    @fita_cadeia
  end

  def cursor
    @cursor
  end
end
