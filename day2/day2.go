// first program in go, lets se how it *go*es :)
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

	// testData := []string{"forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"}
	input, _ := readLines("input.txt")

	for i := range input {
		foo(input[i], &x, &depth)
		printCoords(&x, &depth)
	}

	result := x * depth
	fmt.Println("Result: ", result)
}

func foo(raw string, x *int, depth *int) {
	if strings.Contains(raw, "forward") {
		value, _ := strconv.Atoi(raw[8:])
		*x += value
		fmt.Println("Moved", value, "spaces forward!")
		
	} else if strings.Contains(raw, "up") {
		value, _ := strconv.Atoi(raw[3:])
		*depth -= value
		fmt.Println("Moved", value, "spaces up!")

	} else if strings.Contains(raw, "down") {
		value, _ := strconv.Atoi(raw[5:])
		*depth += value
		fmt.Println("Moved", value, "spaces down!")
	}
}

func printCoords(x *int, y *int) {
	fmt.Println("Coords:", *x, *y)
}

func readLines(path string) ([]string, error) {
    file, err := os.Open(path)
    if err != nil {
        return nil, err
    }
    defer file.Close()

    var lines []string
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        lines = append(lines, scanner.Text())
    }
    return lines, scanner.Err()
}
