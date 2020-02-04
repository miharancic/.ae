/**
 *  https://github.com/tadija/AE
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AECli
import protocol Foundation.LocalizedError

struct Router: TaskDomain {
    var id: String {
        "ae"
    }

    func handle(_ task: Task, in cli: Cli) throws {
        if task.arguments.count > 1 {
            var arguments = Array(task.arguments.dropFirst())
            if task.command.starts(with: "--") {
                arguments[0] = String(task.command.dropFirst(2))
                arguments.insert("core", at: 0)
                try cli.process(arguments)
            } else {
                try cli.process(arguments)
            }
        } else {
            outputHelp(in: cli)
        }
    }
}

extension Router {
    func outputHelp(in cli: Cli) {
        let domains = cli.domains
            .filter({ $0.id != self.id })
            .map({ $0.id })
            .joined(separator: " | ")
        cli.output.text(
            """
            command line personal assistant

            USAGE: ae [domain] [command] [parameters]

            DOMAINS:
                \(domains)

            """
        )
    }
}

extension CliError: LocalizedError {
    public var errorDescription: String? {
        "Domain \"\(task.domain)\" not found."
    }
}
