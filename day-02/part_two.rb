
def init
  sum = 0
 

  File.open("input.txt",'r') do |f|
    f.each_line do |line|
      max = {
        "red" => 1,
        "green" => 1,
        "blue" => 1
      }

      line_data = line.split(/:|;/)

      line_data.slice(1,line_data.length).each do |game|

        game.split(', ').each do |cubes|
          qua,color = cubes.split(' ')

          if qua.to_i > max[color] 
            max[color] = qua.to_i
          end
          
        end

      end

      print max
      puts

      sum += max["red"] * max["green"] * max["blue"]
    end
  end

  puts sum
end


init
