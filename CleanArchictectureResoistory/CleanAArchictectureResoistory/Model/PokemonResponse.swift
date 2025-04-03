//
//  PokemonResponse.swift
//  CleanAArchictectureResoistory
//
//  Created by Rashad Milton on 3/12/25.
//

import Foundation
// MARK: - PokemonResponse
struct PokemonResponse: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable, Identifiable {
    let name: String
    let url: String
}
extension Result {
    var id: String {
        return name + url
    }
}
