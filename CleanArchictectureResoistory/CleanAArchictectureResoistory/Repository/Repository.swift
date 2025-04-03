//
//  Repository.swift
//  CleanAArchictectureResoistory
//
//  Created by Rashad Milton on 3/12/25.
//

import Foundation
protocol RepositoryActions {
    func getData<T: Decodable>() async throws-> T
}
class PokemonRepository: RepositoryActions {
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getData<T: Decodable>() async throws -> T {
        guard let url = URL(string: PokemonEndpoint.Pokemon) else {
            throw NetError.invalidURL
        }
        do {
            let responseData = try await networkService.fetch(url: url, model: T.self)
            print(responseData)
            return responseData
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
