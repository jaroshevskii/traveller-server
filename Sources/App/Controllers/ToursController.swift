//
//  File.swift
//  
//
//  Created by Sasha Jaroshevskii on 24.06.2024.
//

import Vapor

final class ToursController: RouteCollection, Sendable {
    private let tourManager = TourManager()
    
    func boot(routes: RoutesBuilder) throws {
        let searchRoutes = routes.grouped("tours")
        searchRoutes.get("countriesNames", use: countriesNames)
//        searchRoutes.get("resorts", use: getResorts)
//        searchRoutes.get("departureCities", use: getDepartureCities)
    }
    
    @Sendable private func countriesNames(req: Request) throws -> [String] {
        return tourManager.countries.map { $0.name }
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
    
//    @Sendable private func getDepartureCities(req: Request) throws -> [String] {
//        guard let countryName = req.query[String.self, at: "countryName"],
//              let resortName = req.query[String.self, at: "resortName"] else {
//            throw Abort(.badRequest, reason: "Required query parameters are missing")
//        }
//        
//        guard let country = Tour.sampleData.map({ $0.country }).first(where: { $0.name.lowercased() == countryName.lowercased() }) else {
//            throw Abort(.notFound, reason: "Country '\(countryName)' not found")
//        }
//        
//        let resortNames = country.resorts.map { $0.name }
//        
//        let resort = country.resorts.map({ $0.name }).first(where: { $0.name.lowercased() == countryName.lowercased() })
//
//        guard resortNames.contains(resortName) else {
//            throw Abort(.notFound, reason: "Resort '\(resortName)' not found in country '\(countryName)'")
//        }
//        
//        return resortNames
//    }
}
