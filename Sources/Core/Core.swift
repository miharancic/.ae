/**
 *  https://github.com/tadija/AE
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AECli
import AEShell

struct Core: TaskDomain {
    var version: String {
        "0.1.0"
    }

    func handle(_ task: Task, in cli: Cli) throws {
        switch task.command {
        case "edit":
            try edit()
        case "config":
            try config(in: cli)
        case "reload":
            try reload(in: cli)
        case "update":
            try update(
                in: cli,
                branch: UpdateBranch(from: task.parameters)
            )
        case "version":
            cli.output.text(version)
        default:
            outputHelp(in: cli)
        }
    }
}

extension Core {
    private var cfg: Config {
        AE.config
    }

    func edit() throws {
        try Shell(at: cfg.localPath).run("xed .")
    }

    func config(in cli: Cli) throws {
        cli.output.text(cfg.description)
    }

    func reload(in cli: Cli) throws {
        func build() throws {
            let result = try Shell(at: cfg.localPath)
                .run("swift build -c release")
            if !result.isEmpty {
                cli.output.text(result)
            }
        }
        func deploy() throws {
            let bin = cfg.cli.binPath.appending("/ae")
            try Shell(at: cfg.localPath)
                .run("cp -f .build/release/ae \(bin)")
            let version = try Shell().run("ae core version")
            cli.output.text("Deployed version \(version) at \(bin)")
        }
        try build()
        try deploy()
    }

    struct UpdateBranch {
        let name: String

        init(from parameters: [String]) {
            guard !parameters.isEmpty else {
                name = "master"; return
            }
            name = parameters[0]
        }
    }

    func update(in cli: Cli, branch: UpdateBranch) throws {
        let shell = Shell(at: cfg.localPath)

        func cleanup() {
            let _ = try? shell.run("git remote remove ae")
        }

        func fetch() throws {
            cleanup()
            try shell.run("git remote add ae \(cfg.repositoryURL)")
            let result = try shell.run("git fetch ae")
            if !result.isEmpty {
                cli.output.text(result)
            }
        }

        func merge() throws {
            let result = try shell
                .run("git merge ae/\(branch.name) --allow-unrelated-histories")
            if !result.isEmpty {
                cli.output.text(result)
            }
        }

        try fetch()

        do {
            try merge()
            cleanup()
        } catch {
            cleanup()
            cli.output.text(
                "Fix merge conflicts and commit changes to finish update."
            )
        }
    }

    func outputHelp(in cli: Cli) {
        cli.output.text(
            """
            domain which drives this thing

            USAGE: core [command] [options]

            COMMANDS:
                edit
                config
                reload
                update
                    branch: any (default: master)
                version

            """
        )
    }
}
