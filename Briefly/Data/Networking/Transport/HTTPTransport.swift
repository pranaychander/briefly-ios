//
//  HTTPTransport.swift
//  Briefly
//
//  Created by Pranay Chander on 08/01/26.
//

import Foundation

protocol HTTPTransport {
    func send(_ request: URLRequest) async throws -> Data
}
