//
//  PokemonViewModel.swift
//  CleanAArchictectureResoistory
//
//  Created by Rashad Milton on 3/12/25.
//

import Foundation
enum ViewState{
    case loading
    case loaded
    case error(Error)
}
final class PokemonViewModel: ObservableObject {
    @Published var list: [Result] = []
    @Published var viewState: ViewState = .loading
    
    private var repo: RepositoryActions
    init(repo: RepositoryActions) {
        self.repo = repo
    }
    
    func fetchPokemons() async {
        do {
            let pokemons: PokemonResponse = try await repo.getData()
            DispatchQueue.main.async{
                self.list = pokemons.results
                self.viewState = .loaded
            }
        } catch {
            print(error.localizedDescription)
            DispatchQueue.main.async{
                self.viewState = .error(error)
            }
        }
    }
}
