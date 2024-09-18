# [NOT WORKING]
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
  time_limit = 0
  record = 0

  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      if (index === 0)
        time_limit = line.split(":")[1].split(" ").join().to_i

      elsif (index === 1)
        record = line.split(":")[1].split(" ").join().to_i
      end
    end
  end

    p wining_time(time_limit, record)
end

init
