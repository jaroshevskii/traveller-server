import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    let tours = ToursController()
    try app.register(collection: tours)
}
