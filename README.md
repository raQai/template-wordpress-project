# template-wordpress-project
Basic template for WordPress related projects.

## repositorries.conf
Use `repositories.conf` to define themes and plugins to pull by adding each repository to a new line.

Requires the following pattern to register a repository:\
`<name>:<repository>`

`name`:\
The name defining the git repository in this project.
This will also be used to create the corresponding directory within the `src` folder.

`repository`:\
The git repository

Comments may be added by prepending a `#`

## TODO
- build all script
  - build from src
  - move to distribution folder
- dockerize
  - scripts for general tasks
  - add cli
  - auto setup
- download of external plugins/themes
- auto build on change