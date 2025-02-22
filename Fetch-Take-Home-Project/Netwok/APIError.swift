//
//  APIError.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

enum APIError: Error {
    case badRequest(error: String)
    case notFound
    case serverError(statusCode: Int)
    case system(description: String)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badRequest(let error):
            return error
        case .notFound:
            return "Content not found"
        case .serverError(let statusCode):
            return "Server error (\(statusCode)). Please try again later."
        case .system(let description):
            return description
        case .unknown:
            return "An unknown error occurred. Please try again later."
        }
    }
}
