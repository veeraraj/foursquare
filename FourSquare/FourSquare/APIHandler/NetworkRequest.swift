//
//  NetworkRequest.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation

public typealias Headers = [String: String]
public typealias QueryParams = [String: String]

public struct NetworkRequest {
    let url: String
    let headers: Headers?
    let body: Data?
    let requestTimeout: Float?
    let httpMethod: HTTPMethod
    let queryParams: QueryParams?
    
    public init(
        url: String,
        headers: Headers? = nil,
        body: Data? = nil,
        requestTimeout: Float? = nil,
        httpMethod: HTTPMethod,
        queryParams: QueryParams? = nil
    ) {
        self.url = url
        self.headers = headers
        self.body = body
        self.requestTimeout = requestTimeout
        self.httpMethod = httpMethod
        self.queryParams = queryParams
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        let finalURL = url.appending(queryParams: queryParams)
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        
        return urlRequest
    }
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
