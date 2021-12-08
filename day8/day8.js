// console.log("advent of code day 8");

const one = 2; // 1 uses two digits
const four = 4; // 4 uses four digits
const seven = 3; // 7 uses three digits
const eight = 7; // 8 uses seven digits

// let test_data = "fgae cfgab fg bagce";

const test_data = [
    "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
    "edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
    "fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
    "fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
    "aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
    "fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
    "dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
    "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
    "egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
    "gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce",
];

const data = getData();
console.log("Test data result: " + fooo(test_data));
console.log("Actual data result: " + fooo(data));

function getData() {
    var fs = require("fs");
    let text = fs.readFileSync("input.txt", "utf-8");
    const lines = text.split("\n");
    return lines;
}

function foo(s) {
    if (s.length == one || s.length == four || s.length == seven || s.length == eight) {
        return true;
    }
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
