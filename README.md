# AE

**command line personal assistant**

> Command line tool which basically does nothing, yet it can do anything (as long as you implement it).

## Installation

- Fork this repository or [create a new from template](https://github.com/tadija/AE/generate)

- Clone your new repository into `~/.ae`

    ```sh
    git clone $YOUR-REPOSITORY-URL ~/.ae
    ```

- Run installation script to build & deploy **ae** into `/usr/local/bin`

    ```sh
    cd ~/.ae && sh ~/.ae/Resources/install.sh
    ```

## Usage

- Run "ae" to check that the installation went fine

    ```sh
    ae
    ```

    It should display instructions and active domains *(only "core" is there by default)*

    ```sh
    command line personal assistant

    USAGE: ae [domain] [command] [parameters]

    DOMAINS:
        core
    ```
    
- Run "ae core" to display its instructions

    ```sh
    ae core
    ```

    This domain also has a few commands

    ```sh
    domain which drives this thing

    USAGE: core [command] [options]

    COMMANDS:
        edit
        config
        reload
        update
            branch: any (default: master)
        version
    ```

- Run "ae core edit" to open this project in Xcode

    ```sh
    ae core edit
    ```

- Create `Sources/My/Hello.swift` with this sample `TaskDomain`

    ```swift
    import AECli
    
    struct Hello: TaskDomain {
        func handle(_ task: Task, in cli: Cli) throws {
            cli.output.text("hello world")
        }
    }
    ```
    
- Create `Sources/My/My+Cli.swift` to activate `Hello` sample

    ```swift
    import AECli

    extension My.Cli {
        func domains() -> [TaskDomain] {
            [Hello()]
        }
    }
    ```

- Run "ae core reload" to build & deploy again

    ```sh
    ae core reload
    ```

    It's also possible to use a shortcut `ae --reload` *(prefix "--" is reserved for core commands)*

- Run "ae" again

    ```sh
    ae
    ```

    Active domains now also include previously added "hello" domain

    ```sh
    command line personal assistant

    USAGE: ae [domain] [command] [parameters]

    DOMAINS:
        core | hello
    ```

- Run a new domain

    ```sh
    ae hello
    ```

    It will output "hello world"

    ```sh
    hello world
    ```

---

*That's pretty much all there is to it. You may use this tool for whatever needs you can think of. 
Now go and make yourself a bunch of useful "domains" which optionally handle some commands with whatever parameters!*

## License
This code is released under the MIT license. See [LICENSE](LICENSE) for details.

---

`#done-for-fun` `#keep-it-simple` `#think-different`
