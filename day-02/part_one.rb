
def init
  sum = 0
  limits = {
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  File.open("input.txt",'r') do |f|
    f.each_line do |line|
      valid = true
      line_data = line.split(/:|;/)

      line_data.slice(1,line_data.length).each do |game|
        game.split(', ').each do |cubes|
          qua,color = cubes.split(' ')

          if qua.to_i > limits[color] 
            valid = false
            break
          end
          
          break if !valid
        end

        break if !valid
      end

    if valid

      sum += line_data[0].split(' ')[1].to_i
    end
    end
  end

  puts sum
end


init
