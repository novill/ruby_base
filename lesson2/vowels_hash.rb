# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
alphabet = ('а'..'я')
vowels = %w[а о и е э ы у ю я]
vowels_hash = {}

alphabet.each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels.include?(letter)
end
