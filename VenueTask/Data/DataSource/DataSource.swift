//
//  DataSource.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation

class DataSource {
    static func provideNetworkDataSource() -> NetworkManagerProtocol {
        return NetworkManager.shared
    }
}
