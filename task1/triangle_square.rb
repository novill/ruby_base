# Площадь треугольника.
# Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
# Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

puts "Программа расчета площади треугольника"
puts "Ведите основание треугольника"
a = gets.chomp.to_i
puts "Введите высоту тругольника"
h = gets.chomp.to_i
puts "Площадь треугольника #{0.5*a*h}"
