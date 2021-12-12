// Advent of Code: Day 11 TypeScript
const relative_positions = [[0, -1], [0, 1], [-1, -1], [-1, 0], [-1, 1], [1, -1], [1, 0], [1, 1]];

function foo(data) {
    const map = data.map(line => line.split('').map(x => parseInt(x)));
    let c = 0;
    for (let i = 0; i < 100; i++) c += step(map);
    return c;
}

function step(arr) {
    const flashes = inc(arr);
    const flashesCount = flash(flashes, arr);
    reset(arr);
    return flashesCount;
}

function inc(arr) {
    const flashes = [];
    for (let i = 0; i < arr.length; i++) {
        for (let j = 0; j < arr[i].length; j++) {
            arr[i][j]++;
            if (arr[i][j] > 9) flashes.push([i, j]);
        }
    }
    return flashes;
}

function flash(flashes, arr) {
    let c = 0;
    while (flashes.length > 0) {
        const[y, x] = flashes.pop()!;
        if (arr[y][x] !== 10) continue;
        c++;
        for (const [dy, dx] of relative_positions) {
            if (arr[y + dy] === undefined || arr[y + dy][x + dx] === undefined || arr[y + dy][x + dx] >= 10) continue;
            arr[y + dy][x + dx]++;
            if (arr[y + dy][x + dx] === 10) flashes.push([y + dy, x + dx]);
        }
    }
    return c;
}

function reset(arr) {
    for (let row = 0; row < arr.length; row++)
        for (let col = 0; col < arr[row].length; col++)
            if ((arr[row][col] as number) > 9)
                arr[row][col] = 0;
}

console.log("Part 1 Result: " + foo(require("fs").readFileSync("input.txt", "utf-8").split("\n")));
