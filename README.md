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
The git repository.

Comments may be added by prepending a `#`.

## build.conf
Use `build.conf` to define how the repositories should be added to the wordpress installation.

Requires one of the following patterns to register the build:\
`<name>:<destination-path>`\
or\
`<name>:<destination-path>:<build-command>:<distribution-path>`

`name`:\
The name defining the git repository in this project. Also see `repositories.conf`.

`destination-path`:\
The folder within the `wp-contents` folder e.g. `plugins`.

`build-command`:\
The full build command. Currentyl this fails if the build command contains any colon `:` characters.

`distribution-path`:\
The actual plugin or theme folder to distribute to the `wp-contents` folder.

If no build command is specyfied, the entire source folder will be copied.

Comments may be added by prepending a `#`.

## Using this wrapper
### Pull repositories
```
#> ./git-foreach
```
### Build
```
#> ./build-all
```
### Running docker
```
#> docker-compose up
```
The container should be reachable through `127.0.0.3:80`. The local address can be specified within the `.env` file.

## TODO
- dockerize
  - scripts for general tasks
  - add cli
  - auto setup
- download of external plugins/themes
- auto build on change