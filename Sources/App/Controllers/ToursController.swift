//
//  File.swift
//  
//
//  Created by Sasha Jaroshevskii on 24.06.2024.
//

import Vapor

final class ToursController: RouteCollection, Sendable {
    private let toursManager = ToursManager()
    
    func boot(routes: RoutesBuilder) throws {
        let searchRoutes = routes.grouped("tours")
        searchRoutes.get("countryNames", use: countriesNames)
        searchRoutes.get("resortNames", use: resortNames)
        searchRoutes.get("departureCities", use: departureCities)
    }
    
    @Sendable private func countriesNames(req: Request) throws -> [String] {
        return toursManager.countries.map { $0.name }
    }
    
    @Sendable private func resortNames(req: Request) throws -> [String] {
        guard let countryName = req.query[String.self, at: "countryName"] else {
            throw Abort(.badRequest, reason: "Required query parameters are missing")
        }
        
        do {
            let resorts = try toursManager.resorts(countryName: countryName)
            return resorts.map { $0.name }
        } catch {
            throw Abort(.notFound, reason: error.localizedDescription)
        }
    }
    
    @Sendable private func departureCities(req: Request) throws -> [DepartureCity] {
        guard let countryName = req.query[String.self, at: "countryName"],
              let resortName = req.query[String.self, at: "resortName"] else {
            throw Abort(.badRequest, reason: "Required query parameters are missing")
        }
        
        do {
            let departureCities = try toursManager.departureCities(countryName: countryName, resortName: resortName)
            return departureCities
        } catch {
            throw Abort(.notFound, reason: error.localizedDescription)
        }
    }
}
