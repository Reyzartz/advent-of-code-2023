def expand_uni uni_map
  exp_uni_map = uni_map.reduce([]){ |uni,row|
    uni.push(row)

    if row.count("#") === 0
      uni.push(row.clone)
    end

    uni
  }

  uni_length = exp_uni_map.length

  exp_uni_map = exp_uni_map[0]
    .each_with_index
    .reduce(Array.new(uni_length).map{|| []}) { 
    |uni, (_ , col_ind)|
      if exp_uni_map.all?{ |row| row[col_ind] === "."}
        uni.each{|row| row.push('.','.')}
      else
        uni.each.with_index{|row , row_index| row.push(exp_uni_map[row_index][col_ind])}
      end

      uni
    }

    exp_uni_map
end

def init
  uni_map = []

  File.open("input.txt","r") do |f|
    f.each_line do |line|
      uni_map.push line.strip.split("")
    end
  end

   expanded_uni_map = expand_uni(uni_map).each 

   galaxy_loc = []

   expanded_uni_map.each.with_index do |row,y|
     row.each.with_index do |item,x|
      if(item === '#')
        galaxy_loc.push([x,y])
      end
     end
   end

   shortest_distaces = 0
   
   (0..galaxy_loc.length - 2).each do |i|
    (i + 1..galaxy_loc.length - 1).each do |j|
      shortest_distaces += (galaxy_loc[i][0] - galaxy_loc[j][0]).abs + (galaxy_loc[i][1] - galaxy_loc[j][1]).abs
    end
  end

  p shortest_distaces
end

init