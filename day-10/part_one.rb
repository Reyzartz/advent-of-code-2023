def get_prev_pos_from_start_pos start_symbol,curr_pos
  if ["|","L","J"].include?start_symbol
    {:y => curr_pos[:y] - 1, :x=> curr_pos[:x] }
  elsif ["-","7"].include?start_symbol
    {:y => curr_pos[:y], :x=> curr_pos[:x] - 1 }
  elsif start_symbol === "F"
    {:y => curr_pos[:y], :x=> curr_pos[:x] + 1 }
  end
end

def get_starting_location_type(start_pos,map)
  prev_x_symbol = map[start_pos[:y]][start_pos[:x] - 1]
  next_x_symbol = map[start_pos[:y]][start_pos[:x] + 1]
  prev_y_symbol = map[start_pos[:y] - 1][start_pos[:x]]
  next_y_symbol = map[start_pos[:y] + 1][start_pos[:x]]

  prev_x_available = ["-","L","F"].include?(prev_x_symbol)
  next_x_available =["-","J","7",].include?(next_x_symbol)
  prev_y_available = ["|","7","F"].include?(prev_y_symbol)
  next_y_available =["|","L","J",].include?(next_y_symbol)


  if(prev_y_available && next_y_available)
    return "|"
  elsif(prev_x_available && next_x_available)
    return "-"
  elsif(prev_y_available && next_x_available)
    return "L"
  elsif(prev_y_available && prev_x_available)
    return "J"
  elsif(prev_x_available && next_y_available)
    return "7"
  elsif(next_x_available && next_y_available)
    return "F"
  end
end

def step(curr_pos, prev_pos, next_symbol)
  dir_offset = {
    "|" => { 
      "-1_0" => {:y => 1, :x => 0},
      "1_0" => {:y => -1, :x => 0},
      },
    "-" => { 
      "0_-1" => {:y => 0, :x => 1},
      "0_1" => {:y => 0, :x => -1},
      },
    "L" => { 
      "-1_0" => {:y => 0, :x => 1},
      "0_1" => {:y => -1, :x => 0},
      },
    "J" =>{ 
      "-1_0" => {:y => 0, :x => -1},
      "0_-1" => {:y => -1, :x => 0},
      },
    "7" => { 
      "0_-1" => {:y => 1, :x => 0},
      "1_0" => {:y => 0, :x => -1},
      },
    "F" => { 
      "0_1" => {:y => 1, :x => 0},
      "1_0" => {:y => 0, :x => 1},
      }
  }

  dir_key = "#{prev_pos[:y] - curr_pos[:y]}_#{prev_pos[:x] - curr_pos[:x]}"

  next_pos = {
    :y => curr_pos[:y] + dir_offset[next_symbol][dir_key][:y],
    :x => curr_pos[:x] + dir_offset[next_symbol][dir_key][:x]
  }

  next_pos
end

def init
  pipe_map = []
  start_pos = { :y => 0, :x => 0}
  
  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      row = line.strip.split("")
      
      if (row.include?("S"))
        start_pos = { :y => index, :x => row.index("S")}
      end
      
      pipe_map.push(row)

    end
  end

  curr_symbol = get_starting_location_type(start_pos, pipe_map)

  prev_pos = get_prev_pos_from_start_pos(curr_symbol, start_pos)

  curr_pos = step(start_pos, prev_pos, curr_symbol)

  curr_symbol = pipe_map[curr_pos[:y]][curr_pos[:x]]

  prev_pos = start_pos

  length = 0

  while curr_symbol != "S"

    updated_pos = step(curr_pos ,prev_pos, curr_symbol)

    prev_pos = curr_pos

    curr_pos = updated_pos

    curr_symbol = pipe_map[curr_pos[:y]][curr_pos[:x]]

    length += 1
  end

  p (length + 1)/2
end

init