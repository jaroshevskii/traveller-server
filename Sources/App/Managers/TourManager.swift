//
//  File.swift
//  
//
//  Created by Sasha Jaroshevskii on 26.06.2024.
//

import Foundation

enum ToursManagerError: LocalizedError {
    case countryNotFound(countryName: String)
    case resortNotFound(countryName: String, resortName: String)
    
    var errorDescription: String? {
        switch self {
        case .countryNotFound(let countryName): "Country '\(countryName)' not found."
        case .resortNotFound(let countryName, let resortName): "Resort '\(resortName)' not found in country '\(countryName)'."
        }
    }
}

final class ToursManager: Sendable {
    private let tours = Tour.sampleData
    
    var countries: [Country] { tours.map { $0.country } }
    
    func resorts(countryName: String) throws -> [Resort] {
        guard let country = countries.first(where: { $0.name.lowercased() == countryName.lowercased() }) else {
            throw ToursManagerError.countryNotFound(countryName: countryName)
        }
        
        return country.resorts
    }
    
    func departureCities(countryName: String, resortName: String) throws -> [DepartureCity] {
        guard let resort = try resorts(countryName: countryName).first(where: { $0.name.lowercased() == resortName.lowercased() }) else {
            throw ToursManagerError.resortNotFound(countryName: countryName, resortName: resortName)
        }
        
        return resort.departureCities
    }
}
