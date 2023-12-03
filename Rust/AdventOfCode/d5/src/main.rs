use std::fs::File;
use std::io::prelude::*;
use std::io::{self, BufReader};
// use std::Vec

fn main() -> io::Result<()> {
    let file_path = "input.txt";
    let mut f = BufReader::new(File::open(file_path)?);
    let mut stacks: Vec<Vec<char>> = Vec::new();
    
    // let lines = f.lines();
    // let l = lines.Item();
    // println!("f: {}", l);
    for (i, line) in f.lines().enumerate().take(8) {
        let l = line.unwrap();
        println!("{}: {}", i, l);

        // let vals = l.chars().enumerate().filter(|i| i.iter.position(0) % 4 == 1);
        for (s, c) in l.chars().skip(1).step_by(4).enumerate() {
            // print!("{}:'{}' ", s, c);
            if s >= stacks.len() {
                stacks.push(Vec::new())
            }
            if c != ' ' {
                stacks[s].insert(0, c)
            }
        }
        // print!("\n");
        io::stdout().flush().unwrap();
        
    }
    for stack in stacks.iter() {
        println!("{}", stack.iter().map(|x| x.to_string() + " ").collect::<String>());
    }

    f = BufReader::new(File::open(file_path)?);
    for (i, line) in f.lines().enumerate().skip(10) {
        let l = line.unwrap();
        println!("{}:'{}' ", i, l);
        let cmd: Vec<_> = l.split(" ").collect();
        let num = cmd[1].parse::<usize>().unwrap();
        let num_from = cmd[3].parse::<usize>().unwrap();
        let num_to = cmd[5].parse::<usize>().unwrap();
        for _i in 0..num {
            let c = stacks[num_from - 1].pop().unwrap();
            println!("moving {}", c);
            stacks[num_to - 1].push(c);
        }
        for stack in stacks.iter() {
            println!("{}", stack.iter().map(|x| x.to_string() + " ").collect::<String>());
        }
        // println!("num: {} num_from: {} num_to: {}", num, num_from, num_to)
    }

    println!("---");
    for stack in stacks.iter() {
        println!("{}", stack.iter().map(|x| x.to_string() + " ").collect::<String>());
    }
    // println!("{}", stacks[0].pop().unwrap());
    // println!("{}", stacks[0].pop().unwrap());
    // println!("{}", stacks[0].pop().unwrap());

    Ok(())
}
