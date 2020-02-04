/**
 *  https://github.com/tadija/AE
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AECli

public struct AE {
    public private(set) static var config: Config = DefaultConfig()

    let cli: Cli

    public init(config: Config = DefaultConfig(),
                output: CliOutput = AECli.Output()) {
        Self.config = config

        var domains: [TaskDomain] = []
        domains += [Router(), Core()]
        domains += config.cli.domains()

        cli = AECli(domains: domains, output: output)
    }

    public func launchCli() {
        cli.launch()
    }
}
