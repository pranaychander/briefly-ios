//
//  DefaultAPIClient.swift
//  Briefly
//
//  Created by Pranay Chander on 08/01/26.
//

import Foundation

final class DefaultAPIClient: APIClient {

    private let transport: HTTPTransport
    private let decoder: JSONDecoder

    init(
        transport: HTTPTransport = URLSessionTransport(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.transport = transport
        self.decoder = decoder
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = try endpoint.asURLRequest()
        let data = try await transport.send(request)
        return try decoder.decode(T.self, from: data)
    }

    func requestData(_ endpoint: APIEndpoint) async throws -> Data {
        let request = try endpoint.asURLRequest()
        return try await transport.send(request)
    }
}
