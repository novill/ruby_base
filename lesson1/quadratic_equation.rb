# frozen_string_literal: true

# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с.
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и
# выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать

puts 'Программа "Квадратное уравнение."'
puts 'Введите 3 коэффициента a, b и с уравнения'
a = gets.to_f
b = gets.to_f
c = gets.to_f

d = (b**2) - 4 * a * c

puts "Дискриминант: #{d}"

if d < 0
  puts 'Корней нет'
elsif d == 0
  x = -b / (2.0 * a)
  puts "Корень: #{x}"
else
  sqrt_d = Math.sqrt(d)
  x1 = (-b - sqrt_d) / (2 * a)
  x2 = (-b + sqrt_d) / (2 * a)
  puts "Корни: #{x1} и #{x2}"
end
