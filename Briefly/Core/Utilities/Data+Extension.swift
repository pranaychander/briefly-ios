//
//  Data+Extension.swift
//  Briefly
//
//  Created by Pranay Chander on 03/02/26.
//

import Foundation

extension Data {
    func prettyPrintedJSONString() -> String? {
        do {
            let object = try JSONSerialization.jsonObject(with: self, options: [])
            let pretty = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys])
            return String(data: pretty, encoding: .utf8)
        } catch {
            return nil
        }
    }

    func printPrettyJSON() {
        if let pretty = prettyPrintedJSONString() {
            print(pretty)
        } else {
            print("Failed to pretty print JSON.")
        }
    }
}
