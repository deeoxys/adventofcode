// Advent of Code: Day 8 📜
function getData() {
    return require("fs").readFileSync("input.txt", "utf-8").split("\n");
}

function foo(s) {
    return (s.length == 2 || s.length == 4 || s.length == 3 || s.length == 7);
}

function fooo(data) {
    let total = 0;
    for (let i = 0; i < data.length; i++) {
        let s = data[i].substr(data[i].indexOf("|") + 2);
        const arr = s.split(" ");    
        for (let j = 0; j < arr.length; j++)
            if (foo(arr[j]) === true)
                total += 1;
    }
    return total;
}

const data = getData();
console.log("Part 1 result: " + fooo(data));
