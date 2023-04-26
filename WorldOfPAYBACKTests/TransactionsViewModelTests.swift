//
//  TransactionsViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Gabriel Rosa on 4/26/23.
//

import XCTest
import Combine
@testable import WorldOfPAYBACK

final class TransactionsViewModelTests: XCTestCase {

    private var viewModel: TransactionsViewModel?
    private var apiDataSourceMock: TransactionsApiDataSourceMock?

    override func setUp() {
        super.setUp()

        apiDataSourceMock = TransactionsApiDataSourceMock()
        viewModel = TransactionsViewModel(apiDataSource: try! XCTUnwrap(apiDataSourceMock))
    }

    func testFetchAllSuccess() throws {
        let transactions = [
            Transaction(
                partnerDisplayName: "REWE Group",
                alias: TransactionAlias(reference: "1"),
                category: 1,
                transactionDetail:
                    TransactionDetail(
                        description: "Punkte sammeln",
                        bookingDate: "2022-04-24T10:59:05+0200",
                        value: TransactionValue(amount: 500.0, currency: "PBP")
                    )
            ),
            Transaction(
                partnerDisplayName: "dm-dogerie markt",
                alias: TransactionAlias(reference: "2"),
                category: 1,
                transactionDetail:
                    TransactionDetail(
                        description: "Punkte sammeln",
                        bookingDate: "2022-06-23T10:59:05+0200",
                        value: TransactionValue(amount: 1000.0, currency: "PBP")
                    )
            )
        ]

        let response = TransactionResponse(items: transactions)

        viewModel?.fetchAll()

        let transactionListPublisher = viewModel?.$transactionList
            .collect(2)
            .first()

        apiDataSourceMock?.fetchSub.send(response)

        awaitPublisher(try XCTUnwrap(transactionListPublisher))

        // Then
        XCTAssertEqual(viewModel?.transactionList.count, 2)
        XCTAssertEqual(viewModel?.transactionList.first?.alias.reference, "2")
        XCTAssertEqual(viewModel?.transactionList.last?.alias.reference, "1")
        XCTAssertEqual(viewModel?.transactionAmoundSum, 1500.0)
        XCTAssertNil(viewModel?.errorMessage)
    }

    func testFetchError() throws {
        viewModel?.fetchAll()

        apiDataSourceMock?.fetchSub.send(completion: .failure(.connectionError("Failed on my test")))

        let errorMessagePublisher = viewModel?.$errorMessage
            .collect(2)
            .first()

        awaitPublisher(try XCTUnwrap(errorMessagePublisher))

        XCTAssertTrue(try XCTUnwrap(viewModel?.transactionList.isEmpty))
        XCTAssertEqual(viewModel?.errorMessage, "Failed on my test")
    }
}
