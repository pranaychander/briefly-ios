//
//  APIEndpoint.swift
//  Briefly
//
//  Created by Pranay Chander on 08/01/26.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
}

extension APIEndpoint {
    var headers: [String: String] { [:] }

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }

        return request
    }
}
