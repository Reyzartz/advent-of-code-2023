def assign_step_loc_to_seed (step_loc,seeds)
  return step_loc.map.with_index do |loc,index|
    if(loc.nil?)
      seeds[index]
    else
      loc
    end
  end
end

def init
  seeds = []
  step_loc = []

  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      if(index === 0)
        seeds = line.split(":")[1].split(" ").map(&:to_i)

        step_loc = Array.new(seeds.length,nil)


      elsif(line.strip.end_with?("map:"))
        
        seeds = assign_step_loc_to_seed(step_loc,seeds)

        step_loc = Array.new(seeds.length,nil)
        
      elsif(line.start_with?(/\d/))
        dest,sour,range = line.split(" ").map(&:to_i)

        step_loc = step_loc.map.with_index do |seed,index|


          if(seed.nil? && seeds[index] >= sour && seeds[index] < (sour + range))
            dest + (seeds[index] - sour)
          else
            seed
          end
        end
      end
    end

    seeds = assign_step_loc_to_seed(step_loc,seeds)
  end
  p seeds.min
end

init