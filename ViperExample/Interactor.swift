//
// Interactor.swift
// ViperExample
//
// Created on 19.12.2021.
// Copyright (c)  APPWOX. All rights reserved.
//
//
//

/*
 Talks with: Presenter
 Class, Protocol
 */
import Foundation

protocol AnyInteractor {
    var presenter:AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else { return } 
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(ErrorType.NetworkFailed))
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([CryptoResponse].self, from: data)
                self.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            }
            catch {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(ErrorType.ParsingFailed))
            }
        }
        task.resume()
    }
}

