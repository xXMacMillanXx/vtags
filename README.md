# vtags

Creates a *tags* file, which is used by Vi/Vim/Neovim with the `:tag <tag_name>` command.

IMPORTANT!
The generated tags file doesn't work for me in Neovim. I'm not sure if this is because of
installed plugins or if Neovim has different tag behavior.
Vi/Vim work fine, but for some reason the tags for functions aren't found.

## Usage

```v
v run main.v file.v [file2.v file3.v ...]
```

This creates a *tags* file in the current directory.

