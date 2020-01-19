//
//  EndPoint.swift
//  MISiS
//
//  Created by Vova SKR on 17.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

indirect enum NetworkEnvironment {
    case scheduleAPI(token: String, institution: String, year: String, group: String, subgroup: Int)
    
}
extension NetworkEnvironment: EndPointType {
    
    var environmentBaseURL : String {
        switch self {
        case .scheduleAPI:
            return "http://91.132.86.212:3682/misis/api/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        return "schedule"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .scheduleAPI:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var task: HTTPTask {
        switch self {
        case .scheduleAPI(let token, let institute, let year, let group, let subgroup):
            return .requestParameters(bodyParameters: ["token": token,
                                                       "institution": institute,
                                                       "year": year,
                                                       "group": group,
                                                       "subgroup": subgroup],
                                      bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }
}



