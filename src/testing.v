module example

import os
import time

pub interface Publicly {
	public()
}

interface Privately {
	private()
}

pub enum Epub {
	a b c
}

enum Epriv {
	a b c
}

pub struct Example_public {}
struct Example_private {}

pub fn does_stuff_publicly() {
	println('Does stuff publicly')
	_ := os.args
}

fn does_stuff_privately() {
	println('Does stuff privately')
	_ := time.now()
}

