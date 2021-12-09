// Advent of Code: Day 5 🇻
import os

fn main() {
	mut grid := [][]int{len: 1000, init: []int{len: 1000}}
	mut test_data :=[][]int{len: 10, init: []int{len: 10}}
	test_data = add(mut test_data, 0, 9, 5, 9)
	test_data = add(mut test_data, 8, 0, 0, 8)
	test_data = add(mut test_data, 9, 4, 3, 4)
	test_data = add(mut test_data, 2, 2, 2, 1)
	test_data = add(mut test_data, 7, 0, 7, 4)
	test_data = add(mut test_data, 6, 4, 2, 0)
	test_data = add(mut test_data, 0, 9, 2, 9)
	test_data = add(mut test_data, 3, 4, 1, 4)
	test_data = add(mut test_data, 0, 0, 8, 8)
	test_data = add(mut test_data, 5, 5, 8, 2)
	lines := os.read_lines("input.txt")?
	for line in lines {
		mut x1 := line.substr(0, line.index(",") or { panic(err) })
		mut y1 := line.substr(line.index(",") or { panic(err) } + 1, line.index(" ") or { panic(err) })
		mut x2 := line.substr(line.index(" ") or { panic(err) } + 4, line.last_index(",") or { panic(err) })
		mut y2 := line.substr(line.last_index(",") or { panic(err) } + 1, line.len)
		grid = add(mut grid, x1.int(), y1.int(), x2.int(), y2.int())
	}
	print("Part 1 result (Test data): ")
	println(get_intersect_point_count(mut test_data))
	print("Part 1 result: ")
	println(get_intersect_point_count(mut grid))
}

fn add(mut grid [][]int, x1 int, y1 int, x2 int, y2 int) ([][]int) {
	if !(x1 == x2 || y1 == y2) {	// diagonals are out of scope
		return grid
	}
	if (x1 < x2 || x1 > x2) && (y1 == y2) {
		for row in 0..grid.len {
			if row == y1 {
				for column in 0..grid[row].len {
					if (column >= x1 && column <= x2) || (column >= x2 && column <= x1) {	// add horizontal line
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
					if (row >= y1 && row <= y2) || (row >= y2 && row <= y1) {	// add vertical line
						grid[row][column] = grid[row][column] + 1
					}
				}
			}
		}
	}
	return grid
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
