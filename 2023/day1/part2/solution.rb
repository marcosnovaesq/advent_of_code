require "benchmark"

def get_first_digit(word, is_reverse = false)
  
  accumulated_word = ""
  word.chars.each do |char|
    if numeric? char
      result = check_end_of_word(accumulated_word)
      return result unless result.nil?
      return char
    end
    result = check_end_of_word(accumulated_word)
    return result unless result.nil?

    if is_reverse
      accumulated_word = char + accumulated_word
    else
      accumulated_word += char
    end
  end
end

MAP = {
  "3": ["one", "two", "six"],
  "4": ["four", "five", "nine"],
  "5": ["three", "seven", "eight"]
}

def check_end_of_word(word)
  ref = ["one", "two", "six", "four", "five", "nine", "three", "seven", "eight"]
  indexes = []
  ref.each do |stringfied|
    if word.include? stringfied
      indexes.push({number: stringfied, index: word.index(stringfied)})
    end
  end
  return nil if indexes.empty?
  return indexes.sort_by {|indexes| indexes[:index] }.first[:number]
end

def numeric?(lookAhead)
  lookAhead.match?(/[[:digit:]]/)
end

STRING_TO_DIGIT_MAP = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9
}

def parse_digit(digit)
  num_array = ["zero","one","two","three","four","five","six","seven","eight","nine","ten"]
  if num_array.include? digit
    num_array.rindex(digit).to_s
  else
    digit
  end
end

time = Benchmark.realtime {
  input_data = File.read("./input.txt").split
  puts "total amount of lines: #{input_data.count}"
  result = input_data.map do |word|
    first_digit = get_first_digit(word)
    last_digit = get_first_digit(word.reverse, true)
    (parse_digit(first_digit) + parse_digit(last_digit)).to_i
  end
  puts "Result: #{result.sum}"
}


puts "Elapsed time: #{time}"

