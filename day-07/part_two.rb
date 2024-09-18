

def get_rank(hand)
  char_set = hand.to_set

  if(char_set.length === 1)
    7
  elsif (char_set.length === 2)
    is_four_of_kind = char_set.find do |char|
      hand.count(char) === 4
    end
    
    is_four_of_kind ? 6 : 5

  elsif (char_set.length === 3)
    is_three_of_kind = char_set.find do |char|
      hand.count(char) === 3
    end
    
    is_three_of_kind ? 4 : 3
  elsif (char_set.length === 4)
    2
  else
    1
  end
end


def compare_char(hand_a, hand_b)
  strengths = {
    "J" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "Q" => 11,
    "K" => 12,
    "A" => 13
  }

  rank_a = hand_a.to_set.to_a.reduce(0){ |max, hand|
        rank = get_rank(hand_a.join().gsub("J",hand).split(""))

        rank > max ? rank : max
      }

  rank_b = hand_b.to_set.to_a.reduce(0){ |max, hand|
        rank = get_rank(hand_b.join().gsub("J",hand).split(""))

        rank > max ? rank : max
      }
  
  if(rank_a === rank_b)
    mis_match_index = hand_a.find_index.with_index {|card,index| strengths[card] != strengths[hand_b[index]]}

    return strengths[hand_a[mis_match_index]] > strengths[hand_b[mis_match_index]] 
  else
    return rank_a > rank_b
  end
end

def sort_hands(hands)
  sorted_hands = hands

  (hands.length - 1).times do 
    for j in (0..(hands.length - 2))
        if ( compare_char(sorted_hands[j][:hand], sorted_hands[j+1][:hand]))
          sorted_hands[j], sorted_hands[j+1] =  sorted_hands[j+1], sorted_hands[j]
        end
    end
  end

  sorted_hands
end

def init
  hands = []

  File.open("input.txt","r") do |f|
    f.each_line.with_index do |line,index|
      hand,bid = line.split(" ")
      hands.push({:hand => hand.split(""), :bid => bid.to_i})
    end
  end

  sorted_bids = sort_hands(hands).map{ |hand| hand[:bid]}

  p sorted_bids.each_with_index.reduce(0) { |sum,(bid,index)| 
    sum += bid * (index + 1)
  }
end

init