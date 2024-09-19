

def init
  path = ''
  map = {}

  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      if(index===0)
        path = line.strip().split("")
      elsif (index > 1)
        key = line.split(" = ")[0].strip()
        values = line.split(" = ")[1].strip().gsub(/\(|\)/,"").split(", ")
        map[key] = values
      end
    end
  end

  curr_key = "AAA"
  path_index = 0

  while curr_key != "ZZZ"
    dir = path[path_index % path.length]

    curr_key = dir === "L" ? map[curr_key][0] : map[curr_key][1]

    path_index += 1
  end

  p path_index
end

init