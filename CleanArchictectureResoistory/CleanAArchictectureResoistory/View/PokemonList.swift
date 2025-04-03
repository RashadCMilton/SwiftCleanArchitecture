//
//  PokemonList.swift
//  CleanAArchictectureResoistory
//
//  Created by Rashad Milton on 3/12/25.
//

import SwiftUI

struct PokemonList: View {
    @StateObject var vm: PokemonViewModel = PokemonViewModel(repo: PokemonRepository(networkService: Network()))
    var body: some View {
        NavigationStack {
            VStack() {
                switch vm.viewState {
                case .loading:
                    EmptyView()
                case .loaded:
                    pokemonList()
                case .error(let error):
                    errorView(error: error)
                }
            }.navigationTitle(Text(LocalizedStringKey("Title")))
                .task {
                    await vm.fetchPokemons()
                }
        }
    }
    @ViewBuilder
    func pokemonList() -> some View {
        List(vm.list) { pokemon in
            PokemonListCell(pokemon: pokemon)
        }//.listStyle(.)
        
    }
    @ViewBuilder
    func errorView(error: Error) -> some View {
        Image(systemName: "exclamationmark.warninglight")
            .resizable()
            .frame(width: .infinity, height: 300)
        Text(error.localizedDescription)
    }
}
#Preview {
    PokemonList()
}
