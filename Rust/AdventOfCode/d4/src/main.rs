use std::fs::File;
use std::io::prelude::*;
use std::io::{self, BufReader};
// use std::Vec

fn main() -> io::Result<()> {
    let file_path = "input.txt";
    let f = BufReader::new(File::open(file_path)?);
    let mut count = 0;
    // let mut grp = Vec::new();

    for line in f.lines() {
        let l = line.unwrap();
        let l1: Vec<_> = l.split(",").collect();
        let a: Vec<_> = l1.first().unwrap().split("-").collect();
        let b: Vec<_> = l1.last().unwrap().split("-").collect();
        // if (a.first().unwrap().parse::<i32>().unwrap() <= b.first().unwrap().parse::<i32>().unwrap() && b.last().unwrap().parse::<i32>().unwrap() <= a.last().unwrap().parse::<i32>().unwrap())
        //     || (b.first().unwrap().parse::<i32>().unwrap() <= a.first().unwrap().parse::<i32>().unwrap() && a.last().unwrap().parse::<i32>().unwrap() <= b.last().unwrap().parse::<i32>().unwrap())
        if ()
        {
            // println!("a: {}, {}", a.first().unwrap(), a.last().unwrap());
            // println!("b: {}, {}", b.first().unwrap(), b.last().unwrap());
            // println!("b: {}, {}", l);
            println!(">> l: {}", l);
            count += 1
        // } else {
        //     println!(
        //         "l: {} | {} {} {} {}",
        //         l,
        //         a.first() <= b.first(),
        //         b.last() <= a.last(),
        //         b.first() <= a.first(), 
        //         a.last() <= b.last()
        //     );
        // }
    }
    // println!()
    println!("count {}", count);

    Ok(())
}
