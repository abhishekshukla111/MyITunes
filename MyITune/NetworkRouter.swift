//
//  NetworkRouter.swift
//  iTunes
//
//  Created by Abhishek Shukla on 17/09/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import Alamofire

let baseUrl = "https://itunes.apple.com/"

enum NetworkRequestError: String, Error {
    case nilRequest
    case nilURL
}

struct RequestHeader {
    var key: String?
    var value: String?
    
    init(key: String?, value: String?) {
        self.key = key
        self.value = value
    }
}

protocol ITunesURLRequestConvertible: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String? { get }
    var parameters: Parameters? { get }
    var headers: [RequestHeader] { get }
    var timeoutInterval: TimeInterval { get }
    var queryParameters: String { get }
    var encoding: ParameterEncoding { get }
}

enum ApiEndPoint: String {
    case ituneSearch = "search"
}

enum NetworkRouter: ITunesURLRequestConvertible {
    case ituneSearch(params: Parameters)
    
    var method: HTTPMethod {
        switch self {
            
        case .ituneSearch:
            return .get
        }
    }
    
    var path: String? {
        switch self {
            
        case .ituneSearch:
            return ApiEndPoint.ituneSearch.rawValue
        }
    }

    var parameters: Parameters? {
        switch self {
        
        default:
            return nil
        }
    }
    
    var queryParameters: String {
        switch self {

        case .ituneSearch(let parms):
            var urlString = ""
            for (key, value) in parms {
                if let value = value as? Int {
                    urlString += "\(key)=\(value)" + "&"
                }
                if let str = value as? String {
                    urlString += "\(key)=\(str)" + "&"
                }
            }
            
            return String(urlString.dropLast())
        }
    }
    
    var headers: [RequestHeader] {
        var headers = [RequestHeader]()
        
        switch self {
            
        default:
            let contentType = RequestHeader(key: "Content-Type", value: "application/json")
            headers.append(contentType)
            return headers
        }
    }
    
    var timeoutInterval: TimeInterval {
        switch self {
            
        default:
            return 60.0
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
            
        default:
            return JSONEncoding.prettyPrinted
        }
    }
    
    func getURLRequest(fromBaseURLString urlString: String) -> URLRequest? {
        
        if urlString.isEmpty {
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest: URLRequest?
        urlRequest = getURLRequest(fromBaseURLString: baseUrl)
        
        let path = self.path ?? ""
        
        guard let url = urlRequest?.url else {
            throw NetworkRequestError.nilURL
        }
        
        if !self.queryParameters.isEmpty {
            // Obtain components
            guard var urlComponents = URLComponents(string: url.absoluteString) else {
                throw NetworkRequestError.nilRequest
            }
            
            // Build URL Component
            urlComponents.path          = "\(urlComponents.path)\(path)"
            urlComponents.query         = self.queryParameters
            
            if let url = urlComponents.url {
                urlRequest = URLRequest(url: url)
            }
        } else {
            // -- Create another URL instance and appending the path
            let url = url.appendingPathComponent(path)
            urlRequest = URLRequest(url: url)
        }
        
        // Append new headers.
        for header in headers {
            if let key = header.key, let value = header.value {
                urlRequest?.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        guard var request = urlRequest else {
            throw NetworkRequestError.nilRequest
        }
        
        request.httpMethod           = method.rawValue
        request.timeoutInterval      = timeoutInterval

        return try self.encoding.encode(request, with: self.parameters)
    }
}
