
use std::io::{self, BufReader};
use std::io::prelude::*;
use std::fs::File;
// use std::Vec

fn main() -> io::Result<()> {
    let file_path = "input.txt" ;
    let f = File::open(file_path)?;
    let f = BufReader::new(f);
    let mut count = 0;

    for line in f.lines() {
        let l = line.unwrap();
        let m = l.split(" ").collect::<Vec<&str>>();
        // let op = m.first();
        let ch = m.last().unwrap();
        // match ch.as_ref() {
        //     "X" => count += 1,
        //     "Y" => count += 2,
        //     "Z" => count += 3,
        //     _ => _=0,
        // }
        // match l.as_ref() {
        //     "A X" => count += 3,
        //     "B Y" => count += 3,
        //     "C Z" => count += 3,
        //     "A Y" => count += 6,
        //     "B Z" => count += 6,
        //     "C X" => count += 6,
        //     _ => _=1,
        // }
        match ch.as_ref() {
            "X" => count += 0,
            "Y" => count += 3,
            "Z" => count += 6,
            _ => _=0,
        }
        match l.as_ref() {
            "A X" => count += 3, 
            "A Y" => count += 1, 
            "A Z" => count += 2, 
            "B X" => count += 1,
            "B Y" => count += 2,
            "B Z" => count += 3,
            "C X" => count += 2,
            "C Y" => count += 3,
            "C Z" => count += 1,
            _ => _=1,
        }
    }
    println!("count: {}", count.to_string());

    Ok(())
}