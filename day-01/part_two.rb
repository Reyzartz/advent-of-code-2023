def init
  strToNum = {
    "1" => "1",
    "one" => "1",
    "2" => "2",
    "two" => "2",
    "3" => "3",
    "three" => "3",
    "4" => "4",
    "four" => "4",
    "5" => "5",
    "five" => "5",
    "6" => "6",
    "six" => "6",
    "7" => "7",
    "seven" => "7",
    "8" => "8",
    "eight" => "8",
    "9" => "9",
    "nine" => "9"
  }

  sum = 0

  File.open("input.txt",'r') do |f|
    f.each_line do |line|
      numStr = line.scan( /(?=(\d|one|two|three|four|five|six|seven|eight|nine))/)
      sum += (strToNum[numStr.first[0]] + strToNum[numStr.last[0]]).to_i
    end
  end

  puts sum
end

init
