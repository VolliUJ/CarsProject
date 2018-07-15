//
//  Api.swift
//  CarsListProject
//
//  Created by MGOLLI on 09.07.2018.
//  Copyright © 2018 MGOLLI. All rights reserved.
//

import Foundation
import Alamofire

enum ApiClient: URLRequestConvertible {

    case create(car: CarModel)
    case getCars()

    static let baseURLString = "https://iteotest-bb88.restdb.io/rest"

    static let headers = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "x-apikey": "5b3dacb6edf3c458803b29be"
    ]
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .getCars:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return "/cars"
        case .getCars():
            return "/cars"
       
        }
    }
    
    var body: Data?{
        switch self {
        case .create(let carModel):
            return carModel.toData()
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try ApiClient.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = ApiClient.headers
        urlRequest.httpBody = body
        
        return urlRequest
    }
}


