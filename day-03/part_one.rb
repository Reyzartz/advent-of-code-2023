def init
  sum = 0

  File.open('input.txt','r') do |f|
    parts = []
    arr = []
    pos = []

    f.each_line do |line|
      parts.push line.chomp

      pos.push line.to_enum(:scan, /\d+/).map { Regexp.last_match.begin(0) }

      arr.push line.scan(/\d+/)

    end

    arr.each.with_index do |line,lineInd|
      line.each.with_index do |num,numInd|
        numPos = pos[lineInd][numInd]
        numLen = num.strip.length

        top = lineInd - 1 > 0 ? parts[lineInd - 1].slice([numPos-1,0].max, numPos === 0 ? numLen + 1 : numLen + 2) : ''

        middle = parts[lineInd].slice([numPos-1,0].max, numPos === 0 ? numLen + 1 : numLen + 2)

        bottom = lineInd + 1 <= arr.length - 1 ? parts[lineInd + 1].slice([numPos-1,0].max,  numPos === 0 ? numLen + 1 : numLen + 2) : ''

        code = top + middle + bottom

        if code.match?(/@|#|\$|%|&|\*|-|\+|=|\//)
          sum += num.to_i
        end
      end
    end
  end
  
  puts sum
end

init