//
//  WebService.swift
//  CrytoCrazy-RxMVVM
//
//  Created by Mustafa Kemal ARDA on 20.11.2023.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parsingError
}

class WebService {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto],CryptoError>) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            } else if let data = data {
                
              let crytoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = crytoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.parsingError))
                }
            }
            
            
        } .resume()
    }
}
