# Arrayメソッド一覧

### Array.new(size, value) #=> array | valueをsize個持ったarrayオブジェクトを返す
# 全要素が同じオブジェクトを参照している
ary = Array.new(3, "hoge")
p ary #=> ["hoge", "hoge", "hoge"]
p ary[0].upcase! #=> "HOGE"
p ary #=> ["HOGE", "HOGE", "HOGE"]

### Array.new(ary) #=> array | 指定されたaryを複製する 浅い複製
p Array.new([1,2,3]) # => [1,2,3]
a = ["a", "b", "c"]
b = Array.new(a)
a.each{|value| value.upcase!}
p a #=> ["A", "B", "C"]
p b #=> ["A", "B", "C"]

### Array.new(size){|index| ... } #=> array | それぞれ違うオブジェクトのvalueをsize個持つarrayオブジェクトを返す
a = Array.new(3) {|index| index}
p a #=> [0,1,2]

b = Array.new(3) {"hoge"}
p b #=> ["hoge", "hoge", "hoge"]
c = b
b[0].upcase!
p b #=> ["HOGE", "hoge", "hoge"]

### Array.try_convert(obj) #=> (array || nil) | to_aryメソッドを使ってobjをarrayへの変換を試みている
# このメソッドは引数が配列がどうかを確かめるために使われている
p Array.try_convert([1]) #=> [1]
p Array.try_convert("a") #=> nil

### self & other #=> array | 積集合 両方の配列に含まれる要素を新しい配列にして返す 重複する要素は取り除かれる
p [1,1,2,3] & [1,3] #=> [1, 3]

### self * times #=> array | selfをtimes回繰り返した配列を返す
a1 = [1, 2, 3]
p a2 = a1 * 3 #=> [1, 2, 3, 1, 2, 3, 1, 2, 3]

### self * sep #=> string | selfの各要素にsepを挟んだstringを返す joinメソッドと同じ
p [1,2,3] * "..." #=> "1...2...3"

### self + other #=> array | selfとotherを繋げる
a = [1,2,3]
b = [3,5,6]
p a + b #=> [1,2,3,3,5,6]

### self - other #=> array | selfからotherを取り除いた配列を返す
a = [1,1,2,3,4,4,4,5]
b = [3,5]
c = [1,4]
p a - b #=> [1,1,2,4,4,4]
p a - c #=> [2,3,5]

### self << obj #=> array | selfにobjを破壊的に追加する
a = ["hoge", "fugo"]
a << :poge
p a #=> ["hoge", "fugo", :poge]

### self <=> other #=> (-1 || 0 || 1 || nil) | selfがotherより小さければ-1、同じ時0、大きい時1、それ以外はnil
# 各要素を順番に見ていくらしい
p [ 1, 2, 3 ] <=> [ 1, 3, 2 ]       #=> -1
p [ 1, 2, 3 ] <=> [ 1, 2, 3 ]       #=> 0
p [ 1, 2, 3 ] <=> [ 1, 2 ]          #=> 1

### self == other #=> boolean | selfとotherをそれぞれ順番に見ていきすべてのvalueが同じ時trueを返す
p [1,2,3] == [1,2,3] #=> true
p [2,3] == [1] #=> false

### self[range] #=> (array || nll) | rangeの範囲にある要素からなる配列を返す
a = [ "a", "b", "c", "d", "e" ]
p a[0..2] #=> ["a", "b", "c"]
p a[0..-1] #=> [ "a", "b", "c", "d", "e" ]
p a[10..11] #=> nil
p a[2..1] #=> []

### self[start, length] #=> (array || nil) | start番目からlength個のvalueを持つ配列を返す 
a = [ "a", "b", "c", "d", "e" ]
a[0, 1]    #=> ["a"]
a[-1, 1]   #=> ["e"]
a[0, 10]   #=> ["a", "b", "c", "d", "e"]
a[0, 0]    #=> []
a[0, -1]   #=> nil
a[10, 1]   #=> nil

### self[index] = value #=> array | index番目にvalueを設定する
# indexが配列の範囲を超える時にはnilが埋め込まれる
a = [0, 1, 2, 3, 4, 5]
a[6] = "hoge"
p a #=> [0, 1, 2, 3, 4, 5, "hoge"]
a[10] = "fugo"
p a #=> [0, 1, 2, 3, 4, 5, "hoge", nil, nil, "fugo"]

### self[range] = value #=> array | selfのrangeの範囲にあるvalueをvalueに置き換える
# rangeが配列の範囲を超える時にはnilを埋め込む
ary = [0, 1, 2, 3, 4, 5]
ary[0..2] = ["a", "b"]
p ary  # => ["a", "b", 3, 4, 5]

ary = [0, 1, 2]
ary[5..6] = "x"
p ary  # => [0, 1, 2, nil, nil, "x"]

ary = [0, 1, 2, 3, 4, 5]
ary[1..3] = "x"
p ary  # => [0, "x", 4, 5]

### all?{|value| ... } #=> boolean || all?(pattern) | ブロックで評価された全てのvalueが真の時trueを返す
ary = [1,2,3,4]
p ary.all? {|value| value > 0} #=> true
p ary.all?{|value| value < 0 } #=> false
p [].all?{|value| value > 0} #=> true
p [].all?{|value| value < 0} #=> true

### any?{|value| ... } #=> boolean || any?(pattern) | ブロックで評価されたvalueが全て偽の時falseを返す
# 一つでもtrueがあれば即座にtrueを返す
ary = [1,2,3,4]
p ary.any?{|value| value > 3} #=> true
p ary.any?{|value| value > 4} #=> false

### push(*obj) || append(*obj) #=> self | 指定されたobj達を順番に配列の末尾に追加していく
ary = [1,2,3]
ary.push(4, 5)
p ary #=> [1,2,3,4,5]
ary.append("hoge", :fugo, "pyo")
p ary #=> [1,2,3,4,5,"hoge", :fugo, "pyo"]