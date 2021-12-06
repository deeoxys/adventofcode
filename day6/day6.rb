# First program with ruby.
# Advent of code day 6.

# data = [3, 4, 3, 1, 2]

dir = File.dirname(__FILE__)
data = File.readlines("#{dir}/input.txt", chomp: true).first.split(",").map(&:to_i)

# puts "Initial state: #{data}"

def foo(list, day)
    if day == 80
        return list
    else
        for i in 0..list.length - 1
            list[i] = list[i] - 1
            if list[i] < 0
                list[i] = 6
                list << 8
            end
        end
        
        day += 1
        # puts "After #{day} day(s): #{list}"
        foo(list, day)
    end
end

new_data = foo(data, 0)
puts new_data.size
