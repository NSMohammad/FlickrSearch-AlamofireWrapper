//
//  Requestable.swift
//  CollectionImagesFlickr
//
//  Created by MuhaMaD on 30/2/1401 AP.
//

import Foundation

public protocol Requestable: Codable {
    static var method: HTTPMethod { get }
    static var path: String { get }
    
    static var requestType: RequestType { get }
    
    static var retriable: Bool { get }
    
    associatedtype ResponseType: Decodable
}

extension Requestable {
    public static var method: HTTPMethod {
        return .post
    }
    
    public static var requestType: RequestType {
        switch method {
        case .post:
            return .jsonBody
        default:
            return .httpHeader
        }
    }
    
    public static var retrible: Bool {
        return true
    }
}

public struct HTTPMethod: BasicType {
    public let rawValue: String
    
    public var description: String { return rawValue }
    
    public var debugDescription: String {
        return "HTTP Method: \(rawValue)"
    }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(_ description: String) {
        rawValue = description.uppercased()
    }
    
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let head = HTTPMethod(rawValue: "HEAD")
    public static let patch = HTTPMethod(rawValue: "PATCH")
}

public enum RequestType {
    case httpHeader
    case jsonBody
    case multipartFromData
    case urlQuery
}








public protocol BasicType: Codable, Hashable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible { }
    
    extension BasicType where RawValue == String {
        public var description: String {
            return rawValue
        }
        
        public var debugDescription: String {
            return rawValue
        }
    }
    

extension BasicType where RawValue == Int {
    public var description: String {
        return String(describing: rawValue)
    }
    
    public var debugDescription: String {
        return String(describing: rawValue)
    }
}
