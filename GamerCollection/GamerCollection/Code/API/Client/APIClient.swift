//
//  APIClient.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 09/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

public class APIClient {
    
    static let shared = APIClient()
    
    let session = Session(configuration: URLSessionConfiguration.default)
    public var baseEndpoint: String {
        return "https://videogames-collection-services.herokuapp.com"
    }
    
    func sendServer<T: APIRequest>(_ request: T,
                                   success: @escaping (T.Response) -> Void,
                                   failure: @escaping (ErrorResponse) -> Void) {
        
        let endpoint = self.endpoint(for: request)
        let parameters = request.body
        let method = request.method
        let adapter = request.adapter
        
//        session.adapter = adapter
        
        let request = session.request(endpoint, method: method, parameters: parameters, encoding: JSONEncoding.default).validate()
        request.response { response in
            
            let statusCode = response.response?.statusCode ?? -1
            
            if statusCode == 201 || statusCode == 204, let data = "{}".data(using: .utf8) {
                do {
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    success(response)
                    return
                } catch {}
                
                let error = ErrorResponse(error: "ERROR_SERVER".localized())
                failure(error)
                return
            } else if statusCode < 400, let data = response.data {
                do {
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    success(response)
                    return
                } catch {
                    self.mapErrorData(data: data, failure: failure)
                }
            } else if statusCode >= 400 && statusCode < 500, let data = response.data {
                self.mapErrorData(data: data, failure: failure)
            } else {
                let error = ErrorResponse(error: "ERROR_SERVER".localized())
                failure(error)
                return
            }
        }
    }
    
    // MARK: - Private functions
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        
        let urlString = "\(baseEndpoint)\(request.resourceName)\(request.resourcePath)"
        return URL(string: urlString)!
    }
    
    private func mapErrorData(data: Data, failure: @escaping (ErrorResponse) -> Void) {
        
        do {
            let response = try JSONDecoder().decode(ErrorResponse.self, from: data)
            failure(response)
            return
        } catch {
            let error = ErrorResponse(error: "ERROR_SERVER".localized())
            failure(error)
            return
        }
    }
    
}
