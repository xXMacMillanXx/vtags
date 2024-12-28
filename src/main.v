module main

import os
import regex

fn handle_groups(reg regex.RE, text string) []string {
	mut ret := []string{}
	mut gi := 0
	for gi < reg.groups.len {
		if reg.groups[gi] >= 0 {
			ret << '${text[reg.groups[gi]..reg.groups[gi + 1]]}'
		}
		gi += 2
	}
	return [ret.join(' '), ret.last()]
}

fn treat_file(filename string, mut tags []string) {
	query := r'^(pub)?\s*(fn)|(enum)|(interface)|(struct)\s+(\w+)'
	mut re := regex.regex_opt(query) or { panic(err) }

	lines := os.read_lines(filename) or {
		eprintln('Error reading file: ${filename}')
		return
	}
	mut base := os.file_name(filename)
	pos := base.last_index('.') or { -1 }
	if pos != -1 {
		base = base[..pos]
	}
	tags << '${base}\t${filename}\t1\n'
	for line in lines {
		start, _ := re.match_string(line)
		if start != -1 {
			x := handle_groups(re, line)
			//println(x)
			address := x.first()
			tag_name := x.last()
			tags << '${tag_name}\t${filename}\t/^${address}/\n'
		}
	}
}

fn main() {
	args := os.args[1..]
	mut files := []string{}
	if args[0] == '.' {
		raw_file_list := os.glob('*.v') or {
			eprintln('Error listing files on pattern "*.v": ${err}')
			return
		}
		files = raw_file_list.clone()
	} else {
		files = args.clone()
	}

	mut tags := []string{}
	for filename in files {
		treat_file(filename, mut tags)
	}
	if tags.len > 0 {
		tags.sort_ignore_case()
		mut file := os.create('tags') or {
			eprintln('Error creating file tags in current directory')
			return
		}
		defer { file.close() }
		for tag in tags {
			file.write_string(tag) or {
				eprintln('Error writing to file tags in current directory')
				return
			}
		}
	}
}
