//
//  NetworkManager.swift
//  MISiS
//
//  Created by Vova SKR on 18.01.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func getSchedule(institution: String, year: String, group: String, subGroup: Int, completion: @escaping (Result<ScheduleModel, Error>) -> ())
}

struct NetworkManager: NetworkManagerProtocol {
    
    private let router = RouterNetwork<NetworkEnvironment>(session: URLSession.shared)
    private let token = "a1f1f38c-df6e-494e-a399-82e85fb618af"
    
    public func getSchedule(institution: String, year: String, group: String, subGroup: Int, completion: @escaping (Result<ScheduleModel, Error>) -> ()) {
        
        router.request(.scheduleAPI(token: token, institution: institution, year: year, group: group, subgroup: subGroup)) { (data, responce, error) in
            
            guard error == nil else { completion(.failure(error!)); return }
            guard let responseData = data else {
                completion(.failure(APIError.requestFailed ))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(ScheduleModelDTO.self, from: responseData)
                let scheduleModel = ScheduleModel(dto: apiResponse) // проверить success на true
               
                completion(.success(scheduleModel))
            } catch {
                print(error)
                completion(.failure(APIError.jsonParsingFailure))
            }
        }
    }
}
