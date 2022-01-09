//
// Presenter.swift
// ViperExample
//
// Created on 19.12.2021.
// Oguzhan Yalcin
//
//
//

/*
 Talks with: Interactor Router View
 Class, Protocol
 */

import Foundation

enum ErrorType: Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router:AnyRouter? {get set}
    var interactor:AnyInteractor? {get set}
    var view:AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[CryptoResponse], Error>)
}

class CryptoPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[CryptoResponse], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
            print("updated")
        case .failure(let error):
            view?.update(with: "Try Again")
            print("error")
        }
    }
}
