def next_char(letter)
  return letter if letter.match(/[^A-Za-z]/)
  13.times { letter = letter.next }
  letter[-1]
end

def rot13(encrypted_text)
  encrypted_text.split('').map { |letter| next_char(letter) }.join('')
end

names = ['Nqn Ybirynpr', 'Tenpr Ubccre', 'Nqryr Tbyqfgvar', 'Nyna Ghevat',
  'Puneyrf Onoontr', 'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss', 'Ybvf Unvog', 'Pynhqr Funaaba', 'Fgrir Wbof',
  'Ovyy Tngrf', 'Gvz Orearef-Yrr', 'Fgrir Jbmavnx', 'Xbaenq Mhfr',
  'Fve Nagbal Ubner', 'Zneiva Zvafxl', 'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv', 'Tregehqr Oynapu']

puts names.map { |name| rot13(name) }
