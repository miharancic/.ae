/**
 *  https://github.com/tadija/AE
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import Core

public struct My: Config {
    struct Cli: CliConfig {}

    public let cli: CliConfig = Cli()

    public init() {}
}
