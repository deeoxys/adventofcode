# Advent of Code: Day 6 💎
test_data = [3, 4, 3, 1, 2]
dir = File.dirname(__FILE__)
data = File.readlines("#{dir}/input.txt", chomp: true).first.split(",").map(&:to_i)
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
        foo(list, day)
    end
end
print "Part 1 result (Test data): "
puts foo(test_data, 0).size
print "Part 1 result: "
puts foo(data, 0).size
