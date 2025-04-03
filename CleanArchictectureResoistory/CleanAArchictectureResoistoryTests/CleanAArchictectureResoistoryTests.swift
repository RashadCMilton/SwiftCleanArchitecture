//
//  CleanAArchictectureResoistoryTests.swift
//  CleanAArchictectureResoistoryTests
//
//  Created by Rashad Milton on 3/12/25.
//

import XCTest
@testable import CleanAArchictectureResoistory

final class CleanAArchictectureResoistoryTests: XCTestCase {
    var repo: PokemonRepository!
    var fakeManager: FakeNetworkManager!
    var vm: PokemonViewModel!
    var stubRepo: StubRepository = StubRepository()
    override func setUpWithError() throws {
        fakeManager = FakeNetworkManager()
        repo = PokemonRepository(networkService: fakeManager)
    }

    override func tearDownWithError() throws {
        fakeManager = nil
        repo = nil
    }

    func testGetData_WhenWeAreExpectingCorrectData() async throws{
        // when
        fakeManager.testPath = "ValidPokemonData"
        let response: PokemonResponse = try await repo.getData()
        
        //then
        XCTAssertNotNil(response)
        XCTAssertEqual(response.results.count, 40)
        let pokemon = response.results.first!
        XCTAssertEqual(pokemon.name, "bulbasaur")
        XCTAssertEqual(pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/")
        XCTAssertEqual(response.count, 1302)
        XCTAssertEqual(response.next, "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40")
        XCTAssertNil(response.previous)
        
    }
    func testGetData_WhenWeAreExpectingParsingError() async throws{
        // when
        fakeManager.testPath = "InvalidPokemonData"
        do {
            let response: PokemonResponse = try await repo.getData()
            XCTAssertEqual(response.results.count, 0)
            XCTAssertNil(response)
        }
        catch {
            XCTAssertNotNil(error)
            print(error.localizedDescription)
           XCTAssertTrue(error is DecodingError)
        }
        
    }
    func testGetData_WhenWeAreExpectingInvalidURLError() async throws{
        // when
        fakeManager.testPath = "InvalidPokemonData1234"
        do {
            let response: PokemonResponse = try await repo.getData()
            XCTAssertEqual(response.results.count, 0)
            XCTAssertNil(response)
        }
        catch {
            XCTAssertNotNil(error)
            print(error.localizedDescription)
            XCTAssertTrue(error as! NetError == NetError.invalidURL)
        }
        
    }
    func testGetData_WhenWeGetNoDataData() async throws{
        // when
        fakeManager.testPath = "Empty"
        do {
            let response: PokemonResponse = try await repo.getData()
            XCTAssertEqual(response.results.count, 0)
            XCTAssertNil(response)
        }
        catch {
            XCTAssertNotNil(error)
        }
        
    }

    func testGetData_WhenWeGetValidData() async throws{
        vm = PokemonViewModel(repo: stubRepo)
        stubRepo.setPokemonResponse(PokemonResponse(count: 10, next: "aURL", previous: nil, results: [Result(name: "pokemonName", url: "aURL")]))
       await vm.fetchPokemons()
       let expectation = XCTestExpectation(description: "Wait for fetchPokemons to update the list")

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               // Assert
            XCTAssertEqual(self.vm.list.count, 1)
            XCTAssertEqual(self.vm.list.first?.name, "pokemonName")
            XCTAssertEqual(self.vm.list.first?.url, "aURL")
               expectation.fulfill()
           }
           
          await fulfillment(of: [expectation], timeout: 1.0)
        
    }
    func testGetData_WhenWeGetNoData() async throws{
        vm = PokemonViewModel(repo: stubRepo)
        let emptyResponse: PokemonResponse? = nil

        stubRepo.setPokemonResponse(emptyResponse)
       await vm.fetchPokemons()
       // let expectation = XCTestExpectation(description: "Wait for fetchPokemons to update the list")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.vm.list.count, 0)
        }
        //await fulfillment(of: [expectation], timeout: 1.0)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
