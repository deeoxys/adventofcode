// Advent of Code: Day 8 📜
function foo(data) {
    let total = 0;
    for (let i = 0; i < data.length; i++) {
        const arr = data[i].substr(data[i].indexOf("|") + 2).split(" ");    
        for (let j = 0; j < arr.length; j++)
            if (arr[j].length == 2 || arr[j].length == 4 || arr[j].length == 3 || arr[j].length == 7)
                total += 1;
    }
    return total;
}

console.log("Part 1 result: " + foo(require("fs").readFileSync("input.txt", "utf-8").split("\n")));
