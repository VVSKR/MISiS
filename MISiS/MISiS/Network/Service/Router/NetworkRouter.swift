//
//  NetworkRouter.swift
//  MISiS
//
//  Created by Vova SKR on 17.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    
}

class RouterNetwork<EndPoint: EndPointType>: NetworkRouter {
    
    let session: URLSession
    private var task: URLSessionTask?
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        do {
            let request = try self.buildRequest(from: route)
            print(String(data: request.httpBody!, encoding: .utf8))
            print(request.httpBody?.count)
            print(request.httpBody)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path))
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
                
            case .request: request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters, request: &request)
                
                
            case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding,
                                              let urlParameters, let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
                
            }
            return request
            
        } catch { throw error }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            
            try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
           
            
        } catch { throw error }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
