// Advent of Code: Day 3 🦀
use std::{
    fs::File,
    io::{prelude::*, BufReader},
    path::Path,
};

fn lines_from_file(filename: impl AsRef<Path>) -> Vec<String> {
    let file = File::open(filename).expect("File not found");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line"))
        .collect()
}

fn main() {
    let p: &str = "input.txt";
    let test_data = lines_from_file(&p);
    let mut data: Vec<Vec<char>> = vec![vec!['0'; test_data.len()]; 12];
    let mut char_index = 0;
    let mut row = 0;
    let x: usize = 12;
    for str in test_data.iter() {
        let char_vec: Vec<char> = str.chars().collect();
        for _chr in char_vec.iter() {
            data[char_index][row] = char_vec[char_index];
            if char_index < x {
                char_index += 1;
            }
            // rust compiler moment
            if char_index >= x {
                char_index = 0;
            }
        }
        row += 1;
    }
    let mut more_ones_than_zeros = vec![false; 12];
    let mut ones = 0;
    let mut zeros = 0;
    row = 0;
    for vec1d in data.iter() {
        for column in vec1d.iter() {
            if *column == '1' {
                ones += 1;
            } else {
                zeros += 1;
            }
        }
        if ones > zeros {
            more_ones_than_zeros[row] = true;
        }
        ones = 0;
        zeros = 0;
        row += 1;
    }
    let mut gamma_rate = [0; 12];
    let mut epsilon_rate = [0; 12];
    for i in 0..more_ones_than_zeros.len() {
        if more_ones_than_zeros[i] {
            gamma_rate[i] = 1;
        } else {
            epsilon_rate[i] = 1;
        }
    }
    let decimal_gamma_rate = bin_to_dec(&gamma_rate);
    let decimal_epsilon_rate = bin_to_dec(&epsilon_rate);
    println!("Part 1 result: {}", decimal_gamma_rate * decimal_epsilon_rate);
}

fn bin_to_dec(v: &[i32]) -> i32 {
    let mut decimal = 0;
    let mut column = 0;
    for binary in v.iter() {
        if *binary == 1 {
            match column {
                0 => decimal += 2048,
                1 => decimal += 1024,
                2 => decimal += 512,
                3 => decimal += 256,
                4 => decimal += 128,
                5 => decimal += 64,
                6 => decimal += 32,
                7 => decimal += 16,
                8 => decimal += 8,
                9 => decimal += 4,
                10 => decimal += 2,
                11 => decimal += 1,
                _ => println!("Error parsing bit"),
            }
        }
        column += 1;
    }
    return decimal;
}
