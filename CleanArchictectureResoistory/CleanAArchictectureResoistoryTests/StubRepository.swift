//
//  StubRepository.swift
//  CleanAArchictectureResoistoryTests
//
//  Created by Rashad Milton on 3/14/25.
//

import Foundation
@testable import CleanAArchictectureResoistory

class StubRepository: RepositoryActions {
    var error: NetError?
    var response: Any?
    func getData<T>() async throws -> T where T : Decodable {
        if error != nil {
            throw error!
        }
        guard let response = response as? T else {
                    throw NetError.noData
                }
        return response
    }
   
}
extension StubRepository {
    func setError(_ error: NetError?) {
        self.error = error
    }
    
    func setPokemonResponse<T: Decodable>(_ pokemonResponse: T?) {
        self.response = pokemonResponse
    }
}
