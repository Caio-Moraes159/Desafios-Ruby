require 'date'

puts "=== CÁLCULO DE JUROS POR ATRASO ==="

print "Digite o valor original da conta (R$): "
valor_original = gets.chomp.to_f

print "Digite a data de vencimento (DD/MM/AAAA): "
data_input = gets.chomp

begin
  data_vencimento = Date.strptime(data_input, '%d/%m/%Y')
rescue ArgumentError
  puts "\n❌ Erro: Formato de data inválido. Por favor, utilize o formato DD/MM/AAAA."
  exit
end

data_hoje = Date.today

if data_hoje <= data_vencimento
  puts "\n A conta está em dia ou vence hoje! Não há cobrança de juros."
  puts "Valor a pagar: R$ #{'%.2f' % valor_original}"
else
  dias_atraso = (data_hoje - data_vencimento).to_i

  taxa_diaria = 0.025

  valor_juros = valor_original * taxa_diaria * dias_atraso

  valor_total = valor_original + valor_juros

  puts "\n--- Relatório de Atraso ---"
  puts "Data de Vencimento: #{data_vencimento.strftime('%d/%m/%Y')}"
  puts "Data de Hoje:       #{data_hoje.strftime('%d/%m/%Y')}"
  puts "Dias de Atraso:     #{dias_atraso} dia(s)"
  puts "---------------------------"
  puts "Valor Original:     R$ #{'%.2f' % valor_original}"
  puts "Valor da Multa:     R$ #{'%.2f' % valor_juros}"
  puts "Valor Total:        R$ #{'%.2f' % valor_total}"
end
