// Advent of Code: Day 2
package main

import (
	"fmt"
	"strings"
	"strconv"
	"os"
	"bufio"
)

func main() {
	var x int = 0
	var depth int = 0
	test_data := []string{"forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"}
	for i := range test_data {
		part1(test_data[i], &x, &depth)
	}
	fmt.Println("Part 1 result (Test data):", (x * depth))
	
	x = 0
	depth = 0
	input, _ := readLines("input.txt")
	for i := range input {
		part1(input[i], &x, &depth)
	}
	fmt.Println("Part 1 result:", (x * depth))
	
	x = 0
	depth = 0
	var aim int = 0
	for i := range test_data {
		part2(test_data[i], &x, &depth, &aim)
	}
	fmt.Println("Part 2 result (Test data):", (x * depth))
	
	x = 0
	depth = 0
	aim = 0
	for i := range input {
		part2(input[i], &x, &depth, &aim)
	}
	fmt.Println("Part 2 result:", (x * depth))
}

func part1(raw string, x *int, depth *int) {
	if strings.Contains(raw, "forward") {
		value, _ := strconv.Atoi(raw[8:])
		*x += value
	} else if strings.Contains(raw, "up") {
		value, _ := strconv.Atoi(raw[3:])
		*depth -= value
	} else if strings.Contains(raw, "down") {
		value, _ := strconv.Atoi(raw[5:])
		*depth += value
	}
}

func part2(raw string, x *int, depth *int, aim *int) {
	if strings.Contains(raw, "forward") {
		value, _ := strconv.Atoi(raw[8:])
		*x += value
		*depth += (value * *aim)
	} else if strings.Contains(raw, "up") {
		value, _ := strconv.Atoi(raw[3:])
		*aim -= value
	} else if strings.Contains(raw, "down") {
		value, _ := strconv.Atoi(raw[5:])
		*aim += value
	}
}

func readLines(path string) ([]string, error) {
    file, _ := os.Open(path)
    defer file.Close()
    var lines []string
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        lines = append(lines, scanner.Text())
    }
    return lines, scanner.Err()
}
