//
//  File.swift
//  
//
//  Created by Sasha Jaroshevskii on 25.06.2024.
//

import Vapor

struct Tour {
    let country: Country
}

struct Country {
    let name: String
    let resorts: [Resort]
}

struct Resort {
    let name: String
    let departureCities: [DepartureCity]
}

struct DepartureCity: Content {
    let name: String
    let travelMode: TravelMode
}

enum TravelMode: Codable {
    case airplane
    case train
    case bus
}

// MARK: - Sample Data
extension Tour {
    static let sampleData = [
        Tour(
            country: Country(
                name: "France",
                resorts: [
                    Resort(
                        name: "Paris",
                        departureCities: [
                            DepartureCity(name: "New York", travelMode: .airplane),
                            DepartureCity(name: "London", travelMode: .airplane),
                            DepartureCity(name: "Berlin", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Nice",
                        departureCities: [
                            DepartureCity(name: "Paris", travelMode: .train),
                            DepartureCity(name: "Geneva", travelMode: .train),
                            DepartureCity(name: "Barcelona", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Cannes",
                        departureCities: [
                            DepartureCity(name: "Paris", travelMode: .train),
                            DepartureCity(name: "London", travelMode: .airplane),
                            DepartureCity(name: "Milan", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Marseille",
                        departureCities: [
                            DepartureCity(name: "Paris", travelMode: .train),
                            DepartureCity(name: "Madrid", travelMode: .airplane),
                            DepartureCity(name: "Amsterdam", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Chamonix",
                        departureCities: [
                            DepartureCity(name: "Geneva", travelMode: .train),
                            DepartureCity(name: "Milan", travelMode: .train),
                            DepartureCity(name: "Zurich", travelMode: .train)
                        ]
                    )
                ]
            )
        ),
        Tour(
            country: Country(
                name: "Italy",
                resorts: [
                    Resort(
                        name: "Rome",
                        departureCities: [
                            DepartureCity(name: "London", travelMode: .airplane),
                            DepartureCity(name: "Paris", travelMode: .airplane),
                            DepartureCity(name: "Berlin", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Venice",
                        departureCities: [
                            DepartureCity(name: "Vienna", travelMode: .airplane),
                            DepartureCity(name: "Munich", travelMode: .airplane),
                            DepartureCity(name: "Zurich", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Florence",
                        departureCities: [
                            DepartureCity(name: "Madrid", travelMode: .airplane),
                            DepartureCity(name: "Geneva", travelMode: .airplane),
                            DepartureCity(name: "Berlin", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Milan",
                        departureCities: [
                            DepartureCity(name: "Paris", travelMode: .airplane),
                            DepartureCity(name: "London", travelMode: .airplane),
                            DepartureCity(name: "Barcelona", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Amalfi",
                        departureCities: [
                            DepartureCity(name: "Rome", travelMode: .train),
                            DepartureCity(name: "Naples", travelMode: .train),
                            DepartureCity(name: "Milan", travelMode: .airplane)
                        ]
                    )
                ]
            )
        ),
        Tour(
            country: Country(
                name: "Japan",
                resorts: [
                    Resort(
                        name: "Tokyo",
                        departureCities: [
                            DepartureCity(name: "Seoul", travelMode: .airplane),
                            DepartureCity(name: "Shanghai", travelMode: .airplane),
                            DepartureCity(name: "Taipei", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Kyoto",
                        departureCities: [
                            DepartureCity(name: "Tokyo", travelMode: .train),
                            DepartureCity(name: "Osaka", travelMode: .train),
                            DepartureCity(name: "Seoul", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Osaka",
                        departureCities: [
                            DepartureCity(name: "Tokyo", travelMode: .train),
                            DepartureCity(name: "Seoul", travelMode: .airplane),
                            DepartureCity(name: "Beijing", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Hakone",
                        departureCities: [
                            DepartureCity(name: "Tokyo", travelMode: .train),
                            DepartureCity(name: "Osaka", travelMode: .train),
                            DepartureCity(name: "Seoul", travelMode: .airplane)
                        ]
                    ),
                    Resort(
                        name: "Nara",
                        departureCities: [
                            DepartureCity(name: "Osaka", travelMode: .train),
                            DepartureCity(name: "Kyoto", travelMode: .train),
                            DepartureCity(name: "Tokyo", travelMode: .train)
                        ]
                    )
                ]
            )
        )
    ]
}
