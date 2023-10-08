

use std::io::{self, BufReader};
use std::io::prelude::*;
use std::fs::File;
// use std::Vec

fn main() -> io::Result<()> {
    let file_path = "input.txt" ;
    let f = File::open(file_path)?;
    let f = BufReader::new(f);
    let mut count = 0;
    let mut elves = Vec::new();

    for line in f.lines() {
        let l = line.unwrap();
        let c = l.parse::<i32>();
        if !c.is_err() {
            // let c = l.parse::<i32>().unwrap();
            count += c.unwrap();
        }
        else {
            elves.push(count);
            count = 0
        }
    }
    elves.push(count);
    let joined: String = elves.iter().map(|&i| i.to_string() + "\n").collect();
    // println!("{}", count.to_string());
    println!("{}", joined);
    println!("max: {}", elves.iter().max().unwrap().to_string());
    elves.sort_by(|a, b| b.cmp(a));
    let top_elves: String = elves[0..3].iter().map(|&i| i.to_string() + "\n").collect();
    println!("{}", top_elves);
    let top_sum: i32 = elves[0..3].iter().sum();
    println!("{}", top_sum.to_string());

    Ok(())
}