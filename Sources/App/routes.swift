import Vapor

struct LoginRequest: Content {
    let username: String
    let password: String
}

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.post("login") { req -> HTTPStatus in
        let loginRequest = try req.content.decode(LoginRequest.self)
        if loginRequest.username == "admin" && loginRequest.password == "admin" {
            return .ok
        } else {
            return .unauthorized
        }
    }
    
    app.get("countries") { req -> [String] in
        let countries = [
            "United States",
            "Canada",
            "United Kingdom",
            "Australia",
            "Germany",
            "France",
            "Japan",
            "China",
            "India",
            "Brazil"
        ]
        return countries
    }
    
    try app.register(collection: SearchController())
    
    struct Product: Content {
        var id: UUID?
        var name: String
        var description: String
    }
    
    let products: [Product] = [
        Product(id: UUID(), name: "Apple", description: "A tasty fruit"),
        Product(id: UUID(), name: "Banana", description: "A yellow fruit"),
        Product(id: UUID(), name: "Carrot", description: "A healthy vegetable"),
        // Add more products as needed
    ]

    app.get("lol") { req -> [Product] in
        guard let query = req.query[String.self, at: "query"] else {
            throw Abort(.badRequest, reason: "Missing search query")
        }
        return products.filter { $0.name.contains(query) || $0.description.contains(query) }
    }
}
