//
//  CryptoViewModel.swift
//  CryptoCrazyUI
//
//  Created by Burcu Daşkafa on 1.06.2023.
//

import Foundation

@MainActor
class CryptoListViewModel: ObservableObject {
    
    @Published var cryptoList = [CryptoViewModel]()
    
    var webService = Webservice()
    
    
    func downloadCrytosContinuation(url: URL) async{
        do{
            let cryptos = try await webService.downloadCurrenciesContinuation(url: url)
            //main actor no needs dispatchqueue
            self.cryptoList = cryptos.map(CryptoViewModel.init)
            
            /*DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }*/
        } catch {
            print(error)
        }
    }
    
    /*
    func downloadCryptosAsync(url: URL) async{
        
        do{
            let cryptos = try await webService.downloadCurrenciesAsync(url: url)
            
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        } catch{
            print(error)
        }
        
    }*/
    
    
    /*
    func downloadCryptos(url: URL){
        webService.downloadCurrencies(url: url) { result in
            switch result {
            case .failure(let error):
                    print(error)
            case .success(let cryptos):
                if let cryptos = cryptos {
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    }
                    
                }
            }
        }
    }*/
    
}






struct CryptoViewModel {
    
    let crypto: CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    
    var currency : String {
        crypto.currency
    }
    
    var price : String {
        crypto.price
    }
}
