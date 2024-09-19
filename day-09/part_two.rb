

def init
  sequences = []

  File.open("input.txt","r") do |f|
    f.each_line do |line|
      sequences.push line.strip.split(" ").map(&:to_i)
    end
  end

  next_sum_arr = sequences.map do |sequence|
    prev_chars = []

    diff_seq = sequence
    
    while !diff_seq.all?(0)
      prev_chars.push(diff_seq.first)
      
      diff_seq  = (0..diff_seq.length - 2).map do |i|
        diff_seq[i + 1] - diff_seq[i]
      end
      
    end

    prev_chars.reverse.reduce(0){|prev_char_sum,prev_char|  prev_char - prev_char_sum}
  end

  p next_sum_arr.sum
end

init