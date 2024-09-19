

def init
  path = ''
  map = {}
  curr_keys = []

  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      if(index===0)
        path = line.strip().split("")
      elsif (index > 1)
        key = line.split(" = ")[0].strip()
        values = line.split(" = ")[1].strip().gsub(/\(|\)/,"").split(", ")
        map[key] = values

        if (key.end_with?("A"))
          curr_keys.push(key)
        end
      end
    end
  end
  
  path_repeat = curr_keys.reduce(path.length) { |memo,start_key|
    path_index = 0

    p start_key

    curr_key = start_key

    while !curr_key.end_with?("Z")
      dir = path[path_index % path.length]
  
        curr_key = dir === "L" ? map[curr_key][0] : map[curr_key][1]
    
        path_index += 1
    end

    memo * (path_index  / path.length)
  }

  puts path_repeat
end

init