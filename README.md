# Go App Boilerplate

![The definition of "boilerplate"](https://i.imgur.com/0xEmAP6.png)

This is a template repository used to simplify the above, as setting this up for every project adds up overtime.

## Usage

```sh
gh repo create -p cyrus01337/go-app-boilerplate --public --clone $(basename $PWD) && \
    gh repo clone $(basename $PWD) .
```

`.` is the current directory, meaning the project will be generated in the directory this command is
invoked under, whereas omitting the `.` (path) creates a sub-directory and goes through the typical
interactive installation.
