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

### assoc(key) #=> array || nil | 配列の配列を検索してその0番目の要素が引数と等しい最初のvalueを返す
ary = [[1,15], [2,25], [3,35]]
p ary.assoc(2) #=> [2, 25]
p ary.assoc(123) #=> nil

### bsearch{|obj| ... } #=> object || nil | ブロック内の処理を二分探索方を使用して検索する
# 要素が見つからない場合はnilを返し、元々sortしておく必要がある
# なんか色々モードがある 公式ドキュメントを参考にする
ary = [0, 4, 7, 10, 12]
p ary.bsearch {|x| x >= 4 } # => 4
p ary.bsearch {|x| x >= 6 } # => 7
p ary.bsearch {|x| x >= -1 } # => 0
p ary.bsearch {|x| x >= 100 } # => nil

### bsearch_index{|obj| ... } #=> integer || nil | ブロック内の処理を二分探索方を使用して検索する
# 要素が見つかった時その要素のindex番号を返し、ない時はnilを返す
# 元々sortしておく必要がある 色々モードがある
ary = [0, 4, 7, 10, 12]
p ary.bsearch_index{|x| x > 0} #=> 1
p ary.bsearch_index { |x| x >=   6 } # => 2
p ary.bsearch_index { |x| x >=  -1 } # => 0
p ary.bsearch_index { |x| x >= 100 } # => nil

### clear #=> self | 全ての要素を削除して空にする
ary = [0,3,4,5]
ary.clear
p ary #=> []

### clone || dup #=> array | selfを複製した配列を返す 浅いコピー
ary = [1,2,3,4]
ary2 = ary.clone
p ary.eql?(ary2) #=> true
p ary.equal?(ary2) #=> false

### map || collect #=> object | 各要素に対してブロックで評価した結果を全て含む配列を返す
ary = ["hoge", "fugo", "poge"]
p ary.collect{|value| value.upcase} #=> ["HOGE", "FUGO", "POGE"]
p ary #=> ["hoge", "fugo", "poge"]

### map! | collect! #=> self | mapとcollectの破壊版
ary = ["hoge", "fugo", "poge"]
ary.collect!{|value| value.upcase!}
p ary #=> ["HOGE", "FUGO", "POGE"]

### combination(n) {|c| ... } #=> (array || Enumerator) | サイズnの組み合わせを全て生成し、それを引数としてブロックを実行する arrayCn
a = [1, 2, 3, 4]
p a.combination(1)     #=> #<Enumerator: [1, 2, 3, 4]:combination(1)>
p a.combination(1).to_a  #=> [[1],[2],[3],[4]]
p a.combination(2).to_a  #=> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
p a.combination(3).to_a  #=> [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
p a.combination(4).to_a  #=> [[1,2,3,4]]
p a.combination(3){|ary| p ary.map(&:to_s) } #=> ["1", "2", "3"], ["1", "2", "4"] ,["1", "3", "4"] ,["2", "3", "4"][1, 2, 3, 4]

### compact #=> array || compact #=> array || nil | 配列からnilを削除した配列を生成して返す
# compact!は配列内にnilが存在しない時nilを返す
ary = [1, nil, 2, nil, 3, nil]
p ary.compact   #=> [1, 2, 3]
p ary           #=> [1, nil, 2, nil, 3, nil]
ary.compact!
p ary           #=> [1, 2, 3]
p ary.compact!  #=> nil

### concat(other) #=> self | selfにotherを末尾に破壊的に連結する
ary = ["hoge", "fugo"]
other = [1, 2, 3]
p ary.concat(other) #=> ["hoge","fugo", 1, 2, 3]
p ary               #=> ["hoge","fugo", 1, 2, 3]

### concat(*other_arrays) #=> self | other_arrayのvalueをselfの末尾に破壊的に連結する
ary = ["hoge", "fugo"]
other1 = [1, 2, 3]
other2 = [4, 5, 6]
ary.concat(other1, other2)
p ary #=> ["hoge", "fugo", 1, 2, 3, 4, 5, 6]

### count #=> integer || count(value) #=> integer || count{|obj| ... } | selfのvalueの数を返す
# ブロックを渡すとブロックを評価して真になったvalueの数を返す
ary = [1, 2, 4, 2.0]
ary2 = ["hoge", "fugo", "hoge", "poge"]
p ary.count #=> 4
p ary.count(2) #=> 2
p ary2.count("hoge") #=> 2
p ary.count{ |value| value % 2 == 0 } #=> 3

### cycle(n=nil){ |obj| block } #=> nil | selfの全要素をn回(n==nilの時は無限に)繰り返しブロックを呼ぶ
a = [["a", "b", "c"]]
# p a.cycle {|x| puts x } #=> 無限に繰り返す
a.cycle(2){|x| p x} #=> ["a", "b", "c"], ["a", "b", "c"]

### delete(value) #=> (object || nil) || delete(value){|obj| ...} #=> obj | 指定されたvalueが存在する時selfから全て取り除く 破壊的
# 等しいvalueが見つかった時最初にヒットしたvalueを返し、存在しない時はnilを返す
# ブロックが与えられている時はselfにvalueが存在しなかった時にブロックを評価してその値を返す
array = [1, 2, 3, 2, 1, 4, 6]
p array.delete(1) #=> 1
p array #=> [2,3,2,4,6]
array.delete("hoge"){|x| p "#{x}にヒットする要素はありません"} #=> "hogeにヒットする要素はありません"

### delete_at(index) #=> object || nil | 指定されたindexのvalueを削除する indexが範囲外の時nilを返す
ary = ["hoge", "fugo", "poge", 3]
p ary.delete_at(0) #=> "hoge"
p ary #=> ["fugo", "poge", 3]
p ary.delete_at(100) #=> nil

### delete_if{|obj| ... } #=> self | reject!{|obj| ... } #=> self || nil | valueを順番に評価し結果が真になったvalueを全て削除する
# delete_ifは常にselfを返すが、reject!は真になるvalueが一つでもあればselfを返し、一つもなければnilを返す
a = [0, 1, 2, 3, 4, 5]
a.delete_if{|x| x % 2 == 0}
p a #=> [1, 3, 5]
p a.reject!{|x| x % 2 == 0}  #=> nil

### difference(*other_arrays) #=> array | selfからother_arraysを取り除いた配列を生成し返す
a = [0, 1, 2, 3, 4, 5]
ary = a.difference([2])
p ary #=> [0, 1, 3, 4, 5]
p [ 1, 'c', :s, 'yep' ].difference([ 1 ], [ 'a', 'c' ])    # => [:s, "yep"]

### dig(index, ...) #=> object || nil #=> self以下のネストしたオブジェクトをdigメソッドを使って再起的に参照する
# 途中のオブジェクトがnilの時はnilを返す
a = [[1, [2, 3]]]
p a.dig(0, 1, 1) #=> 3
p a.dig(0, 1, 4) #=> nil
# p a.dig(0, 0, 0) #=> error
p [42, {foo: :bar}].dig(1, :foo) # => :bar

### drop(n) #=> array | selfを先頭からn番目までを切り取った配列を返す
a = [1, 2, 3, 4, 5, 0]
a.drop(3)             #=> [4, 5, 0]

### drop_while{|element| ... } #=> array | ブロックを評価して最初に偽になった要素の手前を切り捨てた配列を返す
a = [1,2,3,4,5,6]
p a.drop_while{|num| num < 4} #=> [4,5,6]

### empty? #=> boolean | selfの要素数が0の時trueを返す
a = []
b = ["hoge"]
p a.empty? #=> true
p b.empty? #=> false

### eql?(other) #=> boolean | 各要素をそれぞれ順に評価して全要素が等しければtrueを返す
a = ["hoge", "fugo", "poge"]
b = ["hoge", "fugo", "poge"]
c = ["hoge", "poge", "fugo"]
p a.eql?(b) #=> true
p a.eql?(c) #=> false

### fetch(index, ifnone) || fetch(index){|index| ... } | index番目の要素を取得する
# ary[index]とは違いヒットしなかった時に実行する処理を記述することができる
a = [1, 2, 3, 4, 5]
# p a.fetch(10) #=> error
p a.fetch(10, "無い") #=> "無い"
p a.fetch(10){|index| "#{index}番目の要素は存在しません"}

### fill(value) #=> self | 全ての要素にvalueをセットする セットする要素はvalueのコピーではなくvalue自信をセットする
a = [1, 2, 3, 4, 5]
p a.fill(10) #=> [10, 10, 10, 10, 10]
b = ("a".."f").to_a
b = b.fill("a")
b[0].upcase!
p b #=> ["A", "A", "A", "A", "A", "A"]

### fill(value, start, length=nil) || fill(value, range) || fill(start, length=nil) {|index| ... } #=> array | 配列に指定された範囲すべてにvalueをセットする
# 範囲を超えた時はnilをセットする
# 破壊的
a = [0, 1, 2]
p a.fill("hoge", 5..8) #=> [0, 1, 2, nil, nil,"hoge", "hoge", "hoge"]
ary = []
p ary.fill(1..2){|index| index} #=> [nil, 1, 2]
ary = []
p ary.fill(2,4){|index| index} #=> [nil, nil, 2, 3, 4, 5]
ary.clear

### select | filter{|obj| ... } #=> array | 各要素に対してブロックを評価した値がtrueのものを集めた配列を返す
a = (1..6).to_a
p a.select{|value| value % 2 == 0} #=> [2, 4, 6]
p a.filter{|value| value % 3 == 0} #=> [3, 6]

### select! || filter! #=> self || nil | selectとfilterのそれぞれの破壊的メソッド
a = (1..10).to_a
p a.select!{|value| value % 2 == 0} #=> [2,4,6,8,10]
p a.filter!{|value| value % 2 == 0} #=> nil

### find_index(value) || index(value) #=> integer || nil | 条件に一致する要素の位置を返す
a = [1, 0, 3, 1, 3]
p a.index(0) #=> 1
p a.find_index(2) #=> nil
p a.index{|value| value == 3 } #=> 2

### first #=> object || nil | 配列の一番最初の要素を返す
p [1234, "hoge", :fa].first #=> 1234
p [].first #=> nil

### first(n) #=> array | 先頭からnまでの配列を返す
a = (1..8).to_a
p a.first(0) #=> []
p a.first(4) #=> [1,2,3,4]

### flatten(lebel=nil) #=> array || flatten!(level=nil) #=> array || nil | selfを平坦化した配列を返す
a = [(1..2).to_a, ("a".."c").to_a, ("hoge".."hogg").to_a]
p a.flatten #=> [1,2,"a","b","c","hoge", "hogf","hogg"]

### hash #=> integer | selfのハッシュ値を返す
a = ["hoge", "fugo"]
p a.hash #=> -3872394309423943127

### include?(value) #=> boolean | selfにvalueが存在する時trueを返す
a = (0..4).to_a
p a.include?(2) #=> true
p a.include?(55) #=> false

### insert(index, *values) #=> self | selfのindex番目からvaluesを挿入する
a = (1..4).to_a
a.insert(2, *["hoge", "fugo", "poge"])
p a #=> [1, 2, "hoge", "fugo", "poge", 3, 4]
p a.insert(10, "ryohutoshi") #=> [1, 2, "hoge", "fugo", "poge", 3, 4, nil, nil, nil, "ryohutoshi"]

### to_s || inspect #=> string | 人間が読みやすい文字に変換して返す
a = ("hoge".."hogf").to_a
p a.inspect #=> "[\"hoge\", \"hogf\"]"

### intersect?(other(array)) #=> boolean | otherと共通のvalueが少なくとも一つあればtrueを返す
a = [1, 2, 3]
b = [4, 5, 3]
c = [[2]]
p a.intersect?(b) #=> true
p a.intersect?(c) #=> false

### intersection(*other_arrays) #=> array | selfとotherの共通valueを配列として返す
p [1,2,1,3].intersection([2,4,3], ["hoge", "guo", 3]) #=> [3]
p [1, 2, 3].intersection([1,2,3], ["hoge", "hoge"]) #=> []

### join(separate) #=> string | 配列の要素をseparateを挟んで連結した文字列を返す
a = ["hoge", "fugo", "poge"]
p a.join() #=> "hogefugopoge"
p a.join("-") #=> "hoge-fugo-poge"

### keep_if{|value| ... } #=> self | selfから真となる要素を残し偽となる要素を削除する
# 破壊的
a = (1..6).to_a
p a.keep_if{|value| value < 4} #=>  [1, 2, 3]

### last #=> object || nil | selfの最後の要素を返す 存在しない時はnilを返す
a = (0.. 4).to_a
p a.last #=> 4
a.clear
p a.last #=> nil

### last(n) #=> array || [] | selfの末尾からn個の要素から成る配列を返す
a = (0..4).to_a
p a.last(0) #=> []
p a.last(2) #=> [3, 4]

### length || size #=> integer | 配列の長さを返す
a = (0..4).to_a
p a.size #=> 5
p a.length #=> 5

### max #=> (object || nil) || max(n) #=> array | 配列内の最大値を返す
# 引数に数値を渡すと大きい順にn位までの配列を返す
a = (0..4).to_a
p a.max #=> 4
p a.max(3) #=> [4,3,2]
a.clear
p a.max #=> nil

### max{|a, b| ... } #=> (object || nil) || max(n){|a, b| ... } #=> array | ブロックの評価結果で各要素の大小判定を行い、最大の要素または大きい順にn位までの配列を返す
p [].max{|a, b| a <=> b } #=> nil
p [].max(2){|a, b| a <=> b } #=> []
ary = %w(roland hogehogeland fugoland)
p ary.max{ |a, b| a.object_id <=> b.object_id } #=> "fugoland"
p ary.max(2){ |a, b| a.length <=> b.length } #=> ["hogehogeland", "fugoland"]

### min #=> (object || nil) || min(n) #=> array | maxメソッドの逆
p [].min #=> nil
p [].min(100) #=> []
p %w(hoge hog ho h).min #=> "h"
p %w(hoge hog ho h).min(2) #=> ["h", "ho"]

### min{ |a, b| a <=> b } #=> (object || nil) || min(n){ |a, b| a <=> b } | max{}の逆
p [].min{ |a, b| a <=> b } #=> nil
p [].min(10){ |a, b| a <=> b } #=> []

ary = %w(hoge hog ho h)
p ary.min{ |a, b| a.length <=> b.length } #=> "h"
p ary.min(2){ |a, b| a.length <=> b.length } #=> ["h", "ho"]

### minmax #=> [min_object, max_object] | 配列内のmaxとminの要素を要素とするサイズ2の配列を返す
ary = %w(hogehoge hoge h hogehog hog hogeho ho hogeh )
p ary.minmax #=> ["h", "hogehoge"]
p ary.minmax{ |a, b| a.object_id <=> b.object_id } #=> ["hogehoge", "hogeh"]

### none? #=> boolean | ブロックを指定しない時配列の全ての要素が偽の時真を返す
# ブロックを指定した時はブロックの評価結果が全て偽の時真を返す
ary = %w(hoge fugo poge)
p ary.none?{|value| value.length > 5} #=> true
p ary.none?{|value| value.length >= 4} #=> false
p ary.none?(/o/) #=> false
p ary.none? #=> false
p ary.clear.none? #=> true

### one? #=> boolean | ブロックを指定しない時配列の一つの要素だけが真の時真を返す
# ブロックを指定した時はブロックの評価結果が一つの要素だけが真の時真を返す
ary = %w(hoge fugo poge roland)
p ary.one?{|value| value.length >= 5} #=> true
p ary.one?{|value| value.length >= 4} #=> false
p [nil, false, true].one? #=> true
p [nil, true, 99].one? #=> false

### pack(template) #=> string | 難しいので割愛

### permutation(n=self.length) #=> array | サイズnの順列を生成しそれを引数としてブロック実行する
# 引数を省略した時は配列の要素数と同じサイズの配列を返す
ary = (1..3).to_a #=> [1,2,3]
p ary.permutation #=> Enumerator
p ary.permutation(2) #=> Enumerator
p ary.permutation(2).to_a #=> [[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]]
p ary.permutation(3).to_a #=> [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
p ary.permutation(0).to_a #=> [[]]
p ary.permutation(10).to_a #=> []

### pop #=> object || nil | selfの末尾から要素を取り除いてそれを返す 破壊的
# 引数を指定した場合その個数だけ取り除き、それを配列で返す
array = [1, [2, 3], 4]
p array.pop #=> 4
p array.pop #=> [2, 3]
p array #=> 1
p array.pop #=> 1
p array.pop #=> nil
ary = [1, 2, 3]
p ary.pop(2) #=> [2, 3]
p ary #=> [1]

### unshift(*object) || prepend(*object) #=> self | 指定されたobjectの最後から順番にselfの先頭に突っ込んでいく 破壊的
ary = (0..3).to_a
p ary.unshift(43,21,33) #=> [43,21,33,0,1,2,3]
p ary.prepend("hoge", "fugo") #=> ["hoge","fugo", 43,21,33,0,1,2,3]

### product(*lists) #=> array | レシーバーの配列と引数に渡された配列のそれぞれから要素を1個ずつとって配列を生成し返す
ary = [0,1,2]
p ary.product([4,5]) #=> [[0, 4], [0, 5], [1, 4], [1, 5], [2, 4], [2, 5]]

### rassoc(obj) #=> (array || nil) | 自身が配列の配列であると仮定して要素の配列でindex1の要素がobjに等しいものを検索し見つかった最初の要素を配列にして返す
a = [[15,1], [25,2], [35,3]]
p a.rassoc(2) #=> [25, 2]
p a.rassoc(15) #=> nil

### reject{|value| ... } #=> object | 各要素に対してブロックを評価しその値が偽になった要素で配列を生成し返す
# 逆はselect
a = (0..10).to_a
p a.reject{|item| item < 5} #=> [5,6,7,8,9,10]

### repeated_combination(n) { |value| ... } #=> Array | サイズnの重複組合せを全て生成し、それを引数としてブロックを実行する
a = [1, 2, 3]
p a.repeated_combination(2).to_a #=> [[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]

### repeated_permutation(n) { |value| ... } #=> サイズnの重複順列を全て生成しそれを引数としてブロックを実行する
a = (1..2).to_a
p a.repeated_permutation(a.length).to_a #=> [[1, 1], [1, 2], [2, 1], [2, 2]]

### replace(another) #=> array | 配列の内容を配列anotherで入れ替える 破壊的
a = (0..3).to_a
a.replace([4,5])
p a #=> [4, 5]

### reverse #=> array | selfの配列を逆順にした配列を返す reverse!は破壊的
a = (1..3).to_a
p a.reverse #=> [3,2,1]
p a #=> [1, 2, 3]

### reverse_each { |item| ... } | selfを逆順からブロックを評価する
a = (1..4).to_a
a.reverse_each{|a| p a * 2} #=> 8, 6, 4, 2

### rindex(value) #=> (integer || nil) | 指定されたvalueと等値の最後のvalueの位置を返す 存在しいなければnilを返す
# ブロックが渡された時はselfを逆から評価して最初にtrueとなったvalueの位置を返す
p [0,1,1,2,3].rindex(1) #=> 2
p [0,0,1,2].rindex(4) #=> nil
p [0,0,1,2,3].rindex{|value| value.eql?(0)} #=> 1

### rotate(index=1) #=> array | 引数で指定したindexのvalueが先頭にくる配列を返す
# 引数のindexより前のvalueは末尾に移動する
# 引数のindexに負の数を渡すと逆の操作を行う
# rotate!は破壊的
a = (1..4).to_a
p a.rotate(0) #=> [1,2,3,4]
p a.rotate(1) #=> [2,3,4,1]
p a.rotate(2) #=> [3,4,1,2]
p a.rotate(3) #=> [4,1,2,3]
p a.rotate(4) #=> [1,2,3,4]
p a.rotate(-1) #=> [4,1,2,3]

### sample(n) #=> (object || nil || array) | selfの中からランダムに(引数を指定した場合n個)1個valueを取得し返す
a = (1..4).to_a
p a.sample #=> random
p a.sample(2) #=> [random, random]
p [].sample #=> nil

### shift(n) #=> (object || nil || array) | selfの先頭のvalueを取り出し返す
# 引数を指定した場合はその個数を取り除きその配列を返す
# 破壊的
a = (1..4).to_a
p a.shift #=> 1
p a #=> [2,3,4]
p [].shift #=> nil

### shuffle #=> random | selfをシャッフルした配列を返す
# shuffle!は破壊的
a = (1..4).to_a
p a.shuffle #=> ランダムにシャッフルした配列 長さはselfの要素数
p a #=> [1,2,3,4]

### slice(index) #=> (object || nil) | 指定されたselfの要素を返す
# slice!は破壊的
a = (1..10).to_a
p a.slice(9) #=> 10
p a.slice(100) #=> nil

### slice(start(index), length) || slice(range) #=> (array || nil) | 引数で指定された条件にあったselfを返す
# slice!は破壊的
a = (0..4).to_a
p a.slice(1, 3) #=> [1,2,3]
p a.slice(0..3) #=> [0,1,2,3]
p a.slice(10, 2) #=> nil

### sort #=> array | selfの内容を<=>演算子を使って並び替えられた配列を返す
# ブロックを渡した時はブロック内容でsortをかける
# sort!は破壊的
ary1 = [ "d", "a", "e", "c", "b" ]
p ary1.sort                             #=> ["a", "b", "c", "d", "e"]

ary2 = ["9", "7", "10", "11", "8"]
p ary2.sort                             #=> ["10", "11", "7", "8", "9"] (文字列としてソートするとこうなる)
p ary2.sort{|a, b| a.to_i <=> b.to_i }  #=> ["7", "8", "9", "10", "11"] (ブロックを使って数字としてソート)

# sort_by を使っても良い
p ary2.sort_by{|x| x.to_i }             #=> ["7", "8", "9", "10", "11"]

### sum(init=0) #=> object | selfの全valueの合計値を返す 引数に初期値を設定する
# [e1, e2, e3].sum は init + e1 + e2 + e3
# ブロックが与えられた時加算する前にブロックを評価する
p [].sum #=> 0
p [].sum(0.0) #=> 0.0
p [1,2,3,4].sum #=> 10
p ["a", "b", "c"].sum("") #=> "abc"
p [[1], [[2]], [3]].sum([]) #=> [1, [2], 3] | [] + [1] + [[2]] + [3]

### take(n) #=> array | selfの先頭からnまでの要素を配列にして返す
a = (0..4).to_a
p a.take(3) #=> [0,1,2]

### take_while{ |value| ... } #=> array | selfが偽になるまでブロックを評価し初めてブロックになったvalueの一つ手前までの配列を返す
a = (0..10).to_a
p a.take_while{|value| value <= 6} #=> [0,1,2,3,4,5,6]

### to_h #=> hash | selfを[key, value]のペアを配列として解析した結果をhashにして返す
# ブロックを指定するとselfの各要素でブロックを呼びその結果をペアとして使う
a = [[:hoge, "fugo"], [[:fugo, "fugo"], "FUGO"]]
p a.to_h #=> {:hoge=>"fugo", [:fugo, "fugo"]=>"FUGO"}
p ["hoge", "fugo"].to_h{|value| [value.intern, value]} #=> [:hoge=>"hoge", :fugo=>"fugo"]

### transpose #=> array | 例のようないい感じの配列を返す 配列の長さは全て同じでないといけない
p [[1, 2], ["hoge", "fugo"], [[:hoge], [:fugo]]].transpose #=> [[1,"hoge", [:hoge]], [2, "fugo", [:fugo]]]
p [].transpose #=> []

### union(*ohter_arrays) #=> array | selfとother_arraysの和集合を返す 重複する要素は取り除かれる
p ["a", "b", "c"].to_a.union(["b", "c"], ["d"]) #=> ["a", "b", "c", "d"]

### uniq #=> array || unip! #=> (array || nil) | selfから重複したvalueを取り除いた配列を返す
a = [1,2,1,2,3,3,4]
p a.uniq #=> [1,2,3,4]
p [1,2,3].uniq! #=> nil

### values_at(*index) #=> array | 引数で指定されたindexに対応する要素を配列で返す indexに対応する要素がなければnilを返す
a = (0..5).to_a
p a.values_at(1,3,4) #=> [1,3,4]
p a.values_at(1, 3, 4, 100) #= [1,3,4,nil]

### zip(*arrays) #=> [[object]] || zip(*arrays){|ary| ... } #=> nil | transposeのゆるい版みたいなメソッド
p [1,2,3].zip([4,5,6], [7,8,9]) #=> [[1,4,7], [2,5,8], [3,6,9]]
p [1,2].zip([3,4,5,6], [7,8,9,10]) #=> [[1,3,7], [2,4,8]]
p [1,2,3,4].zip([5,6], [7,8]) #=> [[1,5, 7], [2,6,8], [3,nil,nil], [4,nil,nil]]
[1,2,3].zip([4,5,6], [7,8,9]){|ary| p ary} #=> [1, 4, 7], [2, 5, 8], [3, 6, 9]
[1,2,3].zip([4,5,6], [7,8,9]){|a,b,c| p b} #=> 4,5,6

### self | other #=> array | 集合の和演算 selfとotherのどちらかに含まれる要素を配列にして返す
p [1,1,2,4] | [5,2,1,6, 3] #=> [1,2,4,5,6,3]