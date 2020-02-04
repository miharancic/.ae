import XCTest
import AECli
@testable import Core

final class AETests: XCTestCase {
    let ae = AE(
        config: TestConfig(),
        output: TestOutput()
    )

    func testVersion() throws {
        try ae.cli.process(["ae", "core", "version"])
        let output = ae.cli.output as! TestOutput
        XCTAssertEqual(output.text, Core().version)
    }

    func testCoreShortcut() throws {
        try ae.cli.process(["ae", "--version"])
        let output = ae.cli.output as! TestOutput
        XCTAssertEqual(output.text, Core().version)
    }

    func testMy() throws {
        try ae.cli.process(["ae", "hello"])
        let output = ae.cli.output as! TestOutput
        XCTAssertEqual(output.text, "hello world")
    }

    static var allTests = [
        ("testVersion", testVersion),
        ("testCoreShortcut", testCoreShortcut),
        ("testMy", testMy),
    ]
}

struct TestConfig: Config {
    let cli: CliConfig = TestCli()

    struct TestCli: CliConfig {
        func domains() -> [TaskDomain] {
            [Hello()]
        }
    }

    struct Hello: TaskDomain {
        func handle(_ task: Task, in cli: Cli) throws {
            cli.output.text("hello world")
        }
    }
}

class TestOutput: CliOutput {
    var text: String?

    func text(_ text: String) {
        self.text = text
    }
}
