//
//  FakeNetworkManager.swift
//  CleanAArchictectureResoistoryTests
//
//  Created by Rashad Milton on 3/13/25.
//

import Foundation
@testable import CleanAArchictectureResoistory

class FakeNetworkManager: NetworkService {
    var testPath = ""
    func fetch<T>(url: URL?, model: T.Type) async throws -> T where T : Decodable {
        let bundle = Bundle(for: FakeNetworkManager.self)
        guard let urlObj = bundle.url(forResource: testPath, withExtension: "json") else {
            throw NetError.invalidURL
        }
        do {
            let fileData = try Data(contentsOf: urlObj)
            let parsedData = try JSONDecoder().decode(model, from: fileData)
            return parsedData
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    
}
