//
//  WebService.swift
//  MVVMCryptoCurrnecy
//
//  Created by mac on 16.11.2020.
//

import Foundation

class WebService {
    
    func downloadCurrencies(url : URL, completion: @escaping ([CryptoCurrency]?) -> ()) {
    
        URLSession.shared.dataTask(with: url) { (data , response , error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let cryptoList =  try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                print(cryptoList)
                if let cryptoList = cryptoList {
                    completion(cryptoList)
                } 
            }
        }
        //To start process
        .resume()
    }
}
