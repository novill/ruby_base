# 3. Заполнить массив числами фибоначчи до 100
fibonacci = [0, 1]
next_number = 1

while next_number < 100
  fibonacci << next_number
  next_number = fibonacci[-1] + fibonacci[-2]
end
