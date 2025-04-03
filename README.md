# CleanArchitectureRepository

An iOS app that displays a list of Pokemon fetched from the PokeAPI. The app is written in Swift and uses async/await for asynchronous operations within a Clean Architecture approach with Repository pattern.

## Project Description

This app fetches a list of Pokemon from the PokeAPI and displays their names and URLs. It demonstrates the implementation of Clean Architecture with the Repository pattern in Swift, using modern concurrency with async/await.

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Frameworks](#frameworks)
- [Architecture](#architecture)
- [Design Patterns](#design-patterns)
- [API](#api)
- [Localization](#localization)

## Features

- Fetches Pokemon data from PokeAPI
- Displays Pokemon in a list view
- Implements error handling with appropriate UI feedback
- Supports localization

## Project Structure

The project follows Clean Architecture with clear separation of concerns:

- **Models:**
  - `PokemonResponse.swift` - Data models representing the API response
  - `Result.swift` - Model for individual Pokemon

- **Views:**
  - `PokemonList.swift` - Main view displaying the list of Pokemon
  - `PokemonListCell.swift` - Individual cell view for each Pokemon

- **ViewModels:**
  - `PokemonViewModel.swift` - Handles business logic and state management

- **Networking:**
  - `NetworkService.swift` - Protocol-based network layer for API requests
  - `Network.swift` - Implementation of network service using URLSession

- **Repository:**
  - `Repository.swift` - Interface between data sources and the application
  - `PokemonRepository.swift` - Implementation of repository for Pokemon data

## Installation

- Compatible with iOS 15.0+
- Built with Xcode 14.0+
- No external dependencies required

## Frameworks

- **SwiftUI** - For building the user interface
- **Foundation** - For networking and JSON decoding

## Architecture

This application uses Clean Architecture with the Repository pattern:

- **Presentation Layer** - SwiftUI views and view models
- **Domain Layer** - Business logic and interfaces
- **Data Layer** - Repository implementations and data sources

The app follows MVVM (Model-View-ViewModel) within the presentation layer:
- **Model:** Represents the data structure (`PokemonResponse`, `Result`)
- **View:** SwiftUI views displaying the data (`PokemonList`, `PokemonListCell`)
- **ViewModel:** Connects the model and view, handling business logic (`PokemonViewModel`)

## Design Patterns

- **Repository Pattern** - Abstracts the data sources from the rest of the app
- **Dependency Injection** - Services are injected into repositories and view models
- **Protocol-Oriented Programming** - Network and repository layers are built with protocols
- **Modern Concurrency** - Using Swift's async/await for asynchronous operations

## API

The app uses the [PokeAPI](https://pokeapi.co/) to fetch Pokemon data.

Endpoint:
```
https://pokeapi.co/api/v2/pokemon?offset=0&limit=40
```

Response format:
```json
{
  "count": 1118,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
  "previous": null,
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    },
    ...
  ]
}
```

## Localization

The app supports localization with strings files for different languages:
- English: "Pokemon List"
- Spanish: "Lista de Pokémon"
