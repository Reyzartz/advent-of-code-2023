def init
  sum = 0
  File.open("input.txt","r") do |f|
    f.each_line do |line|
      arr1,arr2 = line.split(":")[1].split("|")
      
      matches_count = arr1.split(" ").intersection(arr2.split(" ")).length

      sum += 2**(matches_count-1) if matches_count > 0
    end
  end

  puts sum
end

init