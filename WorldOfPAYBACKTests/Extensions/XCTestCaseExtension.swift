//
//  XCTestCaseExtension.swift
//  WorldOfPAYBACKTests
//
//  Created by Gabriel Rosa on 4/27/23.
//

import XCTest
import Combine

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10
    ) {
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                expectation.fulfill()
            },
            receiveValue: { value in }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()
    }
}
