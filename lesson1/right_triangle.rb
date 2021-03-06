# frozen_string_literal: true

# Прямоугольный треугольник.
# Программа запрашивает у пользователя 3 стороны треугольника и определяет,
# является ли треугольник прямоугольным, используя теорему Пифагора (www-formula.ru) и выводит результат на экран.

# Также, если треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны),
# то дополнительно выводится информация о том, что треугольник еще и равнобедренный.

# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону
# (гипотенуза) и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон.

# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

puts 'Программа "Прямоугольный треугольник."'
puts 'Введите стороны треугольника'
sides = []
3.times { sides << gets.to_f }

diff_sides = sides.uniq.size

square_sides = sides.sort.map { |x| x**2 }
right_triangle = square_sides[2] == (square_sides[1] + square_sides[0])

if diff_sides == 1
  puts 'Треугольник равнобедренный и равносторонний, но не прямоугольный'
elsif right_triangle && diff_sides == 2
  puts 'Треугольник прямоугольный и равнобедренный'
elsif right_triangle
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник не прямоугольный'
end
