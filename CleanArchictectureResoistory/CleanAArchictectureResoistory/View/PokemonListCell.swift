//
//  PokemonListCell.swift
//  CleanAArchictectureResoistory
//
//  Created by Rashad Milton on 3/12/25.
//

import SwiftUI

struct PokemonListCell: View {
    var pokemon: Result
    var body: some View {
        PokemonListCell()
    }
    @ViewBuilder
    func PokemonListCell() -> some View {
        VStack(alignment: .leading){
            Text(pokemon.name)
                .font(.headline)
                .foregroundStyle(.purple)
            Text(pokemon.url)
                .font(.caption)
                .foregroundStyle(.cyan)
            }
    }
}

#Preview {
    PokemonListCell(pokemon: Result(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"))
}
