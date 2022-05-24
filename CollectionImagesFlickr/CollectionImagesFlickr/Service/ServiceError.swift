//
//  ServiceError.swift
//  CollectionImagesFlickr
//
//  Created by MuhaMaD on 30/2/1401 AP.
//

import Foundation

enum ServiceError: LocalizedError {
    
case badHTTPStaus(status: Int, message: String?)
case loginFailed(message: String?)
    case invalideResponse
    
    var errorDescription: String? {
        return nil
    }
}

struct ErrorResponse: Codable {
    let code: Int
    let message: String
}
