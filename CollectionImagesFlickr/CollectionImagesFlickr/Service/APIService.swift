//
//  APIService.swift
//  CollectionImagesFlickr
//
//  Created by MuhaMaD on 30/2/1401 AP.
//

import Foundation
import Alamofire

class APIService {
    
    public let baseURL: BaseURL
    
    internal let jsonEncoder: JSONEncoder
    internal let decoder: JSONDecoder
    
    private var session: URLSession!
    
    
    
    init(baseURL: BaseURL) {
        self.baseURL = baseURL
        
        jsonEncoder = JSONEncoder()
        decoder = JSONDecoder()
    }
    
    private func validate(response: HTTPURLResponse?, data: Data?) throws -> Data {
        
        let errorResponse = data.flatMap({try? decoder.decode(ErrorResponse.self, from: $0)})
        
        guard let response = response else {
            throw ServiceError.invalideResponse
        }
        switch response.statusCode {
        case 401 :
            throw ServiceError.loginFailed(message: errorResponse?.message)
        case 400, 402... :
            throw ServiceError.badHTTPStaus(status: response.statusCode, message: errorResponse?.message)
        default:
            break
        }
        
        guard let data = data else {
            throw ServiceError.invalideResponse
        }
        return data
    }
    
    func doCustomRequest<T: Requestable>(_ object: T ,method: Alamofire.HTTPMethod, param: Parameters? = nil, header: HTTPHeaders? = nil, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let url = baseURL.rawValue + type(of: object).path
        AF.request(url , method: method, parameters: param, encoding: JSONEncoding.default, headers: header).response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let validData = try self.validate(response: response.response, data: data)
                    let resualt = try self.decoder.decode(T.self, from: validData)
                    completionHandler(.success(resualt))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }
    
}
