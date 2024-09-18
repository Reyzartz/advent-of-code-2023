
def line_count 
  count=0

  File.open("input.txt","r") do |f|
      f.each_line { count+=1 }
  end

  count
end

def init
  cards_stack = Array.new(line_count,1)

  File.open("index.txt","r") do |f|
    f.each_line.with_index do |line,index|
      arr1,arr2 = line.split(":")[1].split("|")
      
      matches_count = arr1.split(" ").intersection(arr2.split(" ")).length

      matches_count.times do |i|
        cards_stack[index+1+i] += cards_stack[index]
      end
    end
  end

  p cards_stack.sum
end

init