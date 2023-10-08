use std::fs::File;
use std::io::prelude::*;
use std::io::{self, BufReader};
// use std::Vec

fn main() -> io::Result<()> {
    let file_path = "input.txt";
    let f = BufReader::new(File::open(file_path)?);
    let mut count = 0;
    let mut grp = Vec::new();

    for line in f.lines() {
        let l = line.unwrap();
        // let first = &l[..(l.len()/2)];
        // let second = &l[(l.len()/2)..];
        // let intersection: Vec<_> = first.chars().filter(|c| second.contains(*c)).collect();

        // if  {
        grp.push(l);
        println!(
            "c1 grp: {}",
            grp.iter().map(|x| x.to_string() + ",").collect::<String>()
        );
        // }
        if grp.len() >= 3 {
            println!(
                "len: {}, 0: {}, 1: {}, 2: {}",
                grp.len(),
                grp[0],
                grp[1],
                grp[2]
            );
            let intersection: Vec<_> = grp[0]
                .chars()
                .filter(|c| grp[1].contains(*c) && grp[2].contains(*c))
                .collect();
            println!(
                "intersection: {}",
                intersection
                    .iter()
                    .map(|x| x.to_string() + ",")
                    .collect::<String>()
            );
            let c = intersection.first().unwrap();

            let prio = c.to_digit(36).unwrap() - 9 + (if c.is_ascii_uppercase() { 26 } else { 0 });
            count += prio;
            grp.clear();
            println!(
                "c2 grp: {}",
                grp.iter().map(|x| x.to_string() + ",").collect::<String>()
            );
        }

        // println!("prio {}", prio)
    }
    println!("count: {}", count);

    Ok(())
}
