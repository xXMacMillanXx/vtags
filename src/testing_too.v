module example

import os
import time

pub interface Pub {
	public()
}

interface Priv {
	private()
}

pub enum Ex_pub {
	a b c
}

enum Ex_priv {
	a b c
}

pub struct E_public {}
struct E_private {}

pub fn does_publicly() {
	println('Does stuff publicly')
	_ := os.args
}

fn does_privately() {
	println('Does stuff privately')
	_ := time.now()
}

