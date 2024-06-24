import Vapor

struct LoginRequest: Content {
    let username: String
    let password: String
}

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.post("login") { req -> HTTPStatus in
        let loginRequest = try req.content.decode(LoginRequest.self)
        if loginRequest.username == "admin" && loginRequest.password == "admin" {
            return .ok
        } else {
            return .unauthorized
        }
    }
}
