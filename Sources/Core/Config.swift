/**
 *  https://github.com/tadija/AE
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import AECli

public protocol Config: CustomStringConvertible {
    var repositoryURL: String { get }
    var localPath: String { get }

    var cli: CliConfig { get }
}

public extension Config {
    var repositoryURL: String {
        "https://github.com/tadija/AE.git"
    }

    var localPath: String {
        "~/.ae"
    }
}

public protocol CliConfig {
    var binPath: String { get }

    func domains() -> [TaskDomain]
}

public extension CliConfig {
    var binPath: String {
        "/usr/local/bin"
    }

    func domains() -> [TaskDomain] {
        []
    }
}

extension Config {
    public var description: String {
        """
        Repository: \(repositoryURL)
        Path: \(localPath)
        Bin: \(cli.binPath)/ae
        """
    }
}

public struct DefaultConfig: Config {
    public struct DefaultCliConfig: CliConfig {}
    public let cli: CliConfig = DefaultCliConfig()
    public init() {}
}
