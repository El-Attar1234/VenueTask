//
//  HomeService.swift
//  Generic-Base
//
//  Created by Ibtikar on 30/11/2022.
//

import Foundation
import Moya

enum HomeService {
    // swiftlint:disable identifier_name
    case fetchVenues(latLong: String)
}

extension HomeService: TargetType {

    var baseURL: URL {
        Environment.baseURL
        
    }
    
    var path: String {
        switch self {
        case .fetchVenues:
            return "/v2/venues/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchVenues:
            return .get
        }
        
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .fetchVenues(let ll):
            var params: [String: Any] = [:]
            params["ll"] = ll
            // "30,31"
            params["client_id"] = Environment.clientID
                //  "4EQRZPSGKBZGFSERGJY055FRW2OSPJRZYR4C3J0JN2CQQFIV"
            params["client_secret"] =  Environment.clientSecret
            // "AJR4B5LLRONWAJWJJOACHAFLCWS2YJAZMGQNFFZQP0IB3THR"
            params["v"] =  Environment.v
            // "20180910"
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
