require 'json'

json_data = <<~JSON
{
  "estoque": [
    { "codigoProduto": 101, "descricaoProduto": "Caneta Azul", "estoque": 150 },
    { "codigoProduto": 102, "descricaoProduto": "Caderno Universitário", "estoque": 75 },
    { "codigoProduto": 103, "descricaoProduto": "Borracha Branca", "estoque": 200 },
    { "codigoProduto": 104, "descricaoProduto": "Lápis Preto HB", "estoque": 320 },
    { "codigoProduto": 105, "descricaoProduto": "Marcador de Texto Amarelo", "estoque": 90 }
  ]
}
JSON

dados = JSON.parse(json_data)

estoque_atual = {}
dados["estoque"].each do |item|
  estoque_atual[item["codigoProduto"]] = item
end

id_movimentacao = 1
historico_movimentacoes = []

loop do
  puts "\n=== SISTEMA DE CONTROLE DE ESTOQUE ==="
  puts "1. Listar Estoque"
  puts "2. Lançar Movimentação (Entrada/Saída)"
  puts "3. Sair"
  print "Escolha uma opção: "

  opcao = gets.chomp.to_i

  case opcao
  when 1
    puts "\n--- Posição Atual do Estoque ---"
    estoque_atual.each do |codigo, produto|
      puts "Código: #{codigo} | #{produto['descricaoProduto']} | Qtde: #{produto['estoque']}"
    end

  when 2
    print "\nDigite o código do produto: "
    codigo = gets.chomp.to_i

    if estoque_atual.key?(codigo)
      produto = estoque_atual[codigo]

      print "Tipo de movimentação (1 para Entrada, 2 para Saída): "
      tipo = gets.chomp.to_i

      print "Quantidade a ser movimentada: "
      qtde = gets.chomp.to_i

      print "Descrição da movimentação (ex: 'Compra de fornecedor', 'Venda no balcão'): "
      descricao = gets.chomp

      if tipo == 1
        produto["estoque"] += qtde
        tipo_str = "Entrada"

      elsif tipo == 2
        if qtde > produto["estoque"]
          puts "\n ERRO: Saldo insuficiente. Estoque atual é de #{produto['estoque']}."
          next
        else
          produto["estoque"] -= qtde
          tipo_str = "Saída"
        end
      else
        puts "\n Opção de movimentação inválida."
        next
      end

      movimentacao = {
        id: id_movimentacao,
        codigo_produto: codigo,
        tipo: tipo_str,
        quantidade: qtde,
        descricao: descricao
      }
      historico_movimentacoes << movimentacao

      id_movimentacao += 1

      puts "\n Movimentação ##{movimentacao[:id]} registrada com sucesso!"
      puts "Descrição: #{descricao}"
      puts "Produto: #{produto['descricaoProduto']}"
      puts "-> ESTOQUE FINAL ATUALIZADO: #{produto['estoque']} unidades."
    else
      puts "\n Produto não encontrado."
    end

  when 3
    puts "\nSaindo do sistema... Até logo!"
    break
  else
    puts "\n Opção inválida, tente novamente."
  end
end
