//
//  MockTransport.swift
//  BrieflyTests
//
//  Created by Pranay Chander on 08/01/26.
//

import Foundation

final class MockTransport: HTTPTransport {

    var data: Data?
    var error: Error?

    func send(_ request: URLRequest) async throws -> Data {
        if let error {
            throw error
        }
        return data ?? Data()
    }
}

