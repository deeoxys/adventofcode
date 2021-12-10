// Advent of Code 2021: Day 10 🇨#
using System.Text;

class Day10 {
    static void Main(string[] args) {
        string[] test_data = {"{([(<{}[<>[]}>{[]{[(<()>", "[[<[([]))<([[{}[[()]]]", "[{[{({}]{}}([{[{{{}}([]", "[<(<(<(<{}))><([]([]()", "<{([([[(<>()){}]>(<<{{"};
        string[] data = File.ReadAllLines(@"input.txt", Encoding.UTF8);
        System.Console.WriteLine("Part 1 Result (Test data): " + test_data.Sum(s => foo(s)));
        System.Console.WriteLine("Part 1 Result: " + data.Sum(s => foo(s)));
    }

    static int foo(string s) {
        Dictionary<char, char> pairs = new Dictionary<char, char>(){{'(', ')'}, {'[', ']'}, {'{', '}'}, {'<', '>'}};   // map
        Dictionary<char, int> scores = new Dictionary<char, int>(){{')', 3}, {']', 57}, {'}', 1197}, {'>', 25137}};
        Stack<char> stack = new Stack<char>();
        foreach (char c in s) {
            if (pairs.ContainsKey(c)) stack.Push(c);
            else if (c == pairs[stack.Peek()]) stack.Pop();
            else return scores[c];
        }
        return 0;
    }
}
