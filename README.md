# Traveller Server

> **Note:** This project has been moved to [new repository location](https://github.com/Nazar935)

A Swift-based server application for travel services built with Vapor framework.

## Features

- **RESTful API**: Travel booking and destination management endpoints
- **Database Integration**: Fluent ORM for type-safe database operations
- **Authentication**: JWT-based user authentication and authorization
- **Async/Await**: Modern Swift concurrency for high-performance requests
- **Static Deployment**: Optimized builds with static Swift stdlib linking
- **Cross-Platform**: Runs on macOS and Linux environments

## Requirements

- Swift 5.7+
- macOS 12.0+ or Ubuntu 18.04+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/jaroshevskii/traveller-server.git
cd traveller-server
```

2. Build and run:
```bash
swift build -c release --static-swift-stdlib
.build/release/TravellerServer
```

For development:
```bash
swift run
```

## Configuration

Set environment variables:
- `PORT` - Server port (default: 8080)
- `HOST` - Server host (default: 127.0.0.1)

## API

Base URL: `http://localhost:8080`

## License

This project is licensed under the [MIT license](LICENSE.md).
