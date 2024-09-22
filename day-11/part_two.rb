
def init
  uni_map = []

  File.open("input.txt","r") do |f|
    f.each_line do |line|
      uni_map.push line.strip.split("")
    end
  end

   expanded_rows = uni_map.each_with_index.reduce([]){ |memo, (row , index)| row.all?(".") ? memo.push(index) : memo }

   expanded_cols = uni_map[0]
   .each_with_index
   .reduce([]) { 
   |memo, (_ , col_ind)|
     if uni_map.all?{ |row| row[col_ind] === "."}
      memo.push(col_ind)
     else
       memo
     end
   }

   galaxy_loc = []

   uni_map.each.with_index do |row,y|
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

      expanded_cols.each do |col_index|
        start_x = [galaxy_loc[i][0],galaxy_loc[j][0]].min
        end_x = [galaxy_loc[i][0],galaxy_loc[j][0]].max

        if((start_x..end_x).include?(col_index))
          shortest_distaces += 999999
        end
      end

      expanded_rows.each do |row_index|
        start_y = [galaxy_loc[i][1],galaxy_loc[j][1]].min
        end_y = [galaxy_loc[i][1],galaxy_loc[j][1]].max

        if((start_y..end_y).include?(row_index))
          shortest_distaces += 999999
        end
      end
    end
  end

  p shortest_distaces
end

init