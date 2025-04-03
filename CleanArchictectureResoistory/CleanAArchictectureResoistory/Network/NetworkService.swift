//
//  NetworkService.swift
//  CleanAArchictectureResoistory
//
//  Created by Rashad Milton on 3/12/25.
//

import Foundation
enum NetError: Error {
    case invalidURL
    case decodingFailed
    case urlSessionFailed
    case invalidResponse
    case noData
}
struct PokemonEndpoint {
    static let Pokemon = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=40"
}
protocol NetworkService {
    func fetch<T: Decodable>(url: URL?, model: T.Type) async throws -> T
}
class Network: NetworkService {
    var urlSession: URLSession
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    func fetch<T>(url: URL?, model: T.Type) async throws -> T where T : Decodable {
        guard let urlObj = url else {
            throw NetError.invalidURL 
        }
        do {
            let (data, response) = try await urlSession.data(from: urlObj)
            if isValidResponse(response) {
                do {
                    return try JSONDecoder().decode(model, from: data)
                }
                catch {
                    throw NetError.decodingFailed
                }
            }
            else {
                throw NetError.invalidResponse
            }
        } catch {
            throw NetError.urlSessionFailed
        }

    }
}

extension Network {
    func isValidResponse(_ response: URLResponse) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        switch httpResponse.statusCode {
        case 200...300:
            return true
        default:
            return false
        }
    }

}
