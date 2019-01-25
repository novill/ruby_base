# 6. Сумма покупок. 
# Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
# содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

puts 'Сумма покупок. Введите список покупок'
buy = {}

loop do
  puts 'Наименование товара'
  product = gets.chomp
  break if product == 'стоп'
  puts 'Цена'
  price = gets.to_f
  puts 'Количество'
  qty = gets.to_f
  buy[product] = {price: price, qty: qty}
end

all_sum = 0

puts 'Ваша корзина:'
buy.each do |k,v|
  puts "#{k}. Цена: #{v[:price]}. Количество: #{v[:qty]}. Сумма: #{v[:price]*v[:qty]}"
  all_sum += v[:price]*v[:qty]
end
puts "Итого: #{all_sum}"
