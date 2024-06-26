//
//  File.swift
//  
//
//  Created by Sasha Jaroshevskii on 25.06.2024.
//

import Foundation

struct Country {
    let name: String
    let resorts: [Resort]
}

struct Resort {
    let name: String
}

struct Tour {
    let country: Country
}

// MARK: - Sample Data
extension Tour {
    static let sampleData = [
        Tour(
            country: Country(
                name: "France",
                resorts: [
                    Resort(name: "Paris"),
                    Resort(name: "Nice"),
                    Resort(name: "Cannes"),
                    Resort(name: "Marseille"),
                    Resort(name: "Chamonix"),
                ]
            )
        ),
        Tour(
            country: Country(
                name: "Italy",
                resorts: [
                    Resort(name: "Rome"),
                    Resort(name: "Venice"),
                    Resort(name: "Florence"),
                    Resort(name: "Milan"),
                    Resort(name: "Amalfi"),
                ]
            )
        ),
        Tour(
            country: Country(
                name: "Japan",
                resorts: [
                    Resort(name: "Tokyo"),
                    Resort(name: "Kyoto"),
                    Resort(name: "Osaka"),
                    Resort(name: "Hakone"),
                    Resort(name: "Nara"),
                ]
            )
        ),
    ]
}
