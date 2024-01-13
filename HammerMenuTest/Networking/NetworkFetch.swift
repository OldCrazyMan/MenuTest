//
//  URLString.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//

import Foundation

protocol NetworkFetchProtocol {
    func fetchPizza(responce: @escaping (PizzaArray?, Error?) -> Void)
}

class NetworkFetch: NetworkFetchProtocol {
    
    func fetchPizza(responce: @escaping (PizzaArray?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData() { result in
            switch result {
            case .success(let data):
                do {
                    let pizza = try JSONDecoder().decode(PizzaArray.self, from: data)
                    responce(pizza, nil)
                } catch {
                    print("Failed to decode JSON")
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
