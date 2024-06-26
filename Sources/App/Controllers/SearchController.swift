//
//  File.swift
//  
//
//  Created by Sasha Jaroshevskii on 24.06.2024.
//

import Vapor

final class SearchController: RouteCollection, Sendable {
    func boot(routes: RoutesBuilder) throws {
        let searchRoutes = routes.grouped("search")
        searchRoutes.get("countries", use: getCountries)
        searchRoutes.get("resorts", use: getResorts)
    }
    
    @Sendable private func getCountries(req: Request) throws -> [String] {
        return Tour.sampleData.map { $0.country.name }
    }
    
    @Sendable private func getResorts(req: Request) throws -> [String] {
        guard let countryName = req.query[String.self, at: "countryName"] else {
            throw Abort(.badRequest, reason: "Country parameter is missing")
        }
        
        if let country = Tour
            .sampleData
            .map({ $0.country })
            .first(where: { $0.name.lowercased() == countryName.lowercased() }) {

            let resortNames = country.resorts.map { $0.name }
            return resortNames
        } else {
            throw Abort(.notFound, reason: "Country '\(countryName)' not found")
        }
    }
}
