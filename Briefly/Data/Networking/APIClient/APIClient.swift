//
//  APIClient.swift
//  Briefly
//
//  Created by Pranay Chander on 21/12/25.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
    func requestData(_ endpoint: APIEndpoint) async throws -> Data
}
