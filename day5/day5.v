// first program in V. advent of code 5.

import os
// import regex

fn main() {
	
	mut grid := [][]int{len: 1000, init: []int{len: 1000}}	// use 10x10 for test data to work. dont try to print 1000x1000...
	// print_grid(grid)

	// test data
	// grid = add(mut grid, 0, 9, 5, 9)
	// grid = add(mut grid, 8, 0, 0, 8)
	// grid = add(mut grid, 9, 4, 3, 4)
	// grid = add(mut grid, 2, 2, 2, 1)
	// grid = add(mut grid, 7, 0, 7, 4)
	// grid = add(mut grid, 6, 4, 2, 0)
	// grid = add(mut grid, 0, 9, 2, 9)
	// grid = add(mut grid, 3, 4, 1, 4)
	// grid = add(mut grid, 0, 0, 8, 8)
	// grid = add(mut grid, 5, 5, 8, 2)

	lines := os.read_lines("input.txt")?
	for line in lines {
		println(line)
		mut x1 := line.substr(0, line.index(",") or { panic(err) })
		mut y1 := line.substr(line.index(",") or { panic(err) } + 1, line.index(" ") or { panic(err) })
		
		mut x2 := line.substr(line.index(" ") or { panic(err) } + 4, line.last_index(",") or { panic(err) })
		mut y2 := line.substr(line.last_index(",") or { panic(err) } + 1, line.len)
		
		println("x1: [$x1]\ny1: [$y1]\n\nx2: [$x2]\ny2: [$y2]")
		grid = add(mut grid, x1.int(), y1.int(), x2.int(), y2.int())
	}
	
	// print_grid(grid)
	println(get_point_count(mut grid))
	println(get_intersect_point_count(mut grid))
	
	// pattern := r'(^\d{1,3}),(\d{1,3}) -> (\d{1,3}),(\d{1,3}$)'
	// mut re := regex.regex_opt(pattern) or { panic(err) }
	// println(re.get_query())
	// start, end := re.match_string(line)
	// mut gi := 0
	// for gi < re.groups.len {
	// 	if re.groups[gi] >= 0 {
	// 		println('${gi / 2} :[${line[re.groups[gi]..re.groups[gi + 1]]}]')
	// 	}
	// 	gi += 2
	// }
}

fn print_grid(grid [][]int) {
	println("")
	for row in 0..grid.len {
		// println(grid[i])
		for column in 0..grid[row].len {
			value := grid[row][column]
			if value == 1 {
				print("\u001B[32m")
			} else if value > 1 {
				print("\u001B[34m")
			}
			print("$value ")
			if value > 0 {
				print("\u001B[0m")
			}
		}
		println("")
	}
	println("")
}

fn add(mut grid [][]int, x1 int, y1 int, x2 int, y2 int) ([][]int) {
	println("($x1, $y1) -> ($x2, $y2)")

	// if diagonal return
	if !(x1 == x2 || y1 == y2) {
		return grid
	}

	if (x1 < x2 || x1 > x2) && (y1 == y2) {
		for row in 0..grid.len {
			if row == y1 {
				for column in 0..grid[row].len {
					// add horizontal line
					if (column >= x1 && column <= x2) || (column >= x2 && column <= x1) {
						println("[h] $row, $column")
						grid[row][column] = grid[row][column] + 1
					}
				}
			}
		}
	}

	if (y1 < y2 || y1 > y2) && (x1 == x2) {
		for column in 0..grid[0].len {
			if column == x1 {
				for row in 0..grid.len {
					// add vertical line
					if (row >= y1 && row <= y2) || (row >= y2 && row <= y1) {
						println("[v] $row, $column")
							grid[row][column] = grid[row][column] + 1
					}
				}
			}
		}
	}
	return grid
}

fn get_point_count(mut grid [][]int) (int) {
	mut count := 0
	for row in 0..grid.len {
		for column in 0..grid[row].len {
			if grid[row][column] > 0 {
				count++
			}
		}
	}
	return count
}

fn get_intersect_point_count(mut grid [][]int) (int) {
	mut count := 0
	for row in 0..grid.len {
		for column in 0..grid[row].len {
			if grid[row][column] > 1 {
				count++
			}
		}
	}
	return count
}
