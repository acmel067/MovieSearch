//
//  Parser.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import Foundation

struct Parser {
    static func parse<T: Decodable>(type: T.Type, data: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        }
        catch {
            print("Failed to decode JSON")
            return nil
        }
    }
}
