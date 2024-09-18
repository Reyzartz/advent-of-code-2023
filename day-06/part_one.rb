
def wining_time (time,distance)
  min_time = 0

  time.times do |i|
    dis_trvl = i * (time - i)

    if(dis_trvl > distance)
      min_time = i - 1
      break
    end
  end

  # p min_time
  time - (min_time * 2) - 1
end

def init
  time_limits = []
  records = []

  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      if (index === 0)
        time_limits = line.split(":")[1].split(" ").map(&:to_i)

      elsif (index === 1)
        records = line.split(":")[1].split(" ").map(&:to_i)
      end
    end
  end

  p time_limits.each_with_index.reduce([]) {  |m, (t, i)|
    m.push wining_time(time_limits[i], records[i])
    m
}.reduce(:*)
end

init