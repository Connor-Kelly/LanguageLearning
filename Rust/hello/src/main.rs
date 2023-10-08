
use std::io::{self, BufReader};
use std::io::prelude::*;
use std::fs::File;

fn main() -> io::Result<()> {
    let file_path = "content/basic.html" ;
    let f = File::open(file_path)?;
    let f = BufReader::new(f);

    for line in f.lines() {
        let contents = line.as_ref().unwrap();
        match contents.contains("head") {
            true => println!(">>{}", contents),
            false => println!("{}", contents),
        }
        // println!("{}", line.unwrap());
    }

    Ok(())
}
