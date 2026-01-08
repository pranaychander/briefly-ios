//
//  URLSessionTransport.swift
//  Briefly
//
//  Created by Pranay Chander on 08/01/26.
//

import Foundation

final class URLSessionTransport: HTTPTransport {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
