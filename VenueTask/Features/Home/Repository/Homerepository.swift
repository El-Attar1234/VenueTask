//
//  Homerepository.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation

protocol HomeRepositoryProtocol: AnyObject {
    func fetchVenues(latLong: String,
                     completion: @escaping (Result<ServerResponse<VenuesResponse>?, NetworkError>, Int?) -> Void)
}

class HomeRepository: HomeRepositoryProtocol {
    
    private weak var remoteDataSource: NetworkManagerProtocol!
    
    init(remoteDataSource: NetworkManagerProtocol = DataSource.provideNetworkDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchVenues(latLong: String,
                     completion: @escaping (Result<ServerResponse<VenuesResponse>?, NetworkError>, Int?) -> Void) {
        self.remoteDataSource.remoteFetchAndMapping(target: HomeService.fetchVenues(latLong: latLong),
                                                    type: ServerResponse<VenuesResponse>.self
        ) { (response, statusCode) in
            completion(response, statusCode)
        }
    }
  
}
