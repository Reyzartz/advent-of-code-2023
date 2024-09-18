def init

  starCache={

  }

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
        
        middle = parts[lineInd].slice([numPos - 1,0].max, num.length+2)
        
        width = middle.length

        top = lineInd - 1 > 0 ? parts[lineInd - 1].slice([numPos-1,0].max, width) : Array.new(width,'.').join

        bottom = lineInd + 1 <= arr.length - 1 ? parts[lineInd + 1].slice([numPos-1,0].max,  width) : Array.new(width,'.').join

        code = top + middle + bottom

        if(code.include?('*'))
          starPos = code.to_enum(:scan, /\*/).map { Regexp.last_match.begin(0) }

          numGraphPos = code.to_enum(:scan, Regexp.new(num)).map { Regexp.last_match.begin(0) }

          x1,y1 = [numGraphPos[0] % width, numGraphPos[0] / width]

          starPos.each do |pos|
            
              x2,y2 = [pos % width,pos / width]

              x = (x2-x1) + numPos

              y = (y2-y1) + lineInd

            key = "#{x}-#{y}"

            if(starCache[key]===nil)
              starCache[key] = [num.to_i]
            else
              starCache[key].push num.to_i
            end
          end
        end

      end
    end
  end

  t = starCache.values.reduce(0) do |sum,values|
    if values.length >1
      sum += values.inject(:*)
      
      sum
    else
      sum
    end
  end

  puts t
end

init