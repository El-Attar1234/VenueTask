//
//  NetworkManager.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation
import Moya

protocol NetworkManagerProtocol: AnyObject {
    
    func remoteFetchAndMapping<T: Codable>(target: TargetType,
                                           type: T.Type,
                                           completion: @escaping (Result<T?, NetworkError>, Int?) -> Void)
    
}

final class NetworkManager {
    
    typealias MoyaCompletion = Result<Moya.Response, MoyaError>
    typealias NetworkCompletion<T: Codable> = (_ result: Swift.Result<T?, NetworkError>,
                                               _ statusCode: Int?) -> Void
    
    static let shared = NetworkManager()
    let provider: MoyaProvider<MultiTarget>
    
    private init() {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        provider = MoyaProvider<MultiTarget>(
            plugins: [NetworkLoggerPlugin(configuration: loggerConfig)])
    }
    
}

extension NetworkManager: NetworkManagerProtocol {
    
    func remoteFetchAndMapping<T: Codable>(target: TargetType,
                                           type: T.Type,
                                           completion: @escaping (Result<T?, NetworkError>, Int?) -> Void) {
        provider.request(MultiTarget(target)) { (moyaResponse) in
            self.parseResponse(moyaResponse: moyaResponse, completion: completion)
        }
    }
    
}
// MARK: - Parse Json
extension NetworkManager {

    private func parseResponse<T: Codable>(moyaResponse: MoyaCompletion,
                                           completion: @escaping(NetworkCompletion<T>)) {
        switch moyaResponse {
        case .success(let response):
            switch response.statusCode {
                // Successful response
            case 200...299:
                do {
                    let result = try response.map(T.self)
                    completion(.success(result), response.statusCode)
                } catch {
                    completion(.failure(ErrorHandling.resolve(error: error)), response.statusCode)
                }
            default:
                completion(.failure(ErrorHandling.resolve(statusCode: response.statusCode)), response.statusCode)
            }
            
        case .failure(let error):
            completion(.failure(ErrorHandling.resolve(error: error)), nil)
        }
        
    }
}
