require "benchmark"
time = Benchmark.realtime {
  input_data = File.read("./input.txt").split
  puts "total amount of lines: #{input_data.count}"
  correct_calibration_parameters = input_data.map do |tampered_text|
    first_digit = tampered_text[tampered_text.index(/\d/)]
    last_digit = tampered_text[tampered_text.rindex(/\d/)]
    (first_digit + last_digit).to_i
  end
  puts "Result: #{correct_calibration_parameters.sum}"
}

puts "Elapsed time: #{time}"