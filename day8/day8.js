const data = getData();
console.log(fooo(data));

function getData() {
    var fs = require("fs");
    let text = fs.readFileSync("input.txt", "utf-8");
    return text.split("\n");
}

function foo(s) {
    if (s.length == 2 || s.length == 4 || s.length == 3 || s.length == 7) return true;
    return false;
}

function fooo(data) {
    let total = 0;
    for (let i = 0; i < data.length; i++) {
        let s = data[i].substr(data[i].indexOf("|") + 2);
        const arr = s.split(" ");    
        for (let j = 0; j < arr.length; j++) {
            if (foo(arr[j]) === true) {
                total += 1;
            }
        }
    }
    return total;
}
