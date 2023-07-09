//
//  ContentView.swift
//  CryptoCrazyUI
//
//  Created by Burcu Daşkafa on 1.06.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView {
            List(cryptoListViewModel.cryptoList, id:\.id) { crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.orange)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .font(.title2)
                        .foregroundColor(.indigo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.toolbar(content: {
                Button {
                    //button clicked
                    Task.init{
                        cryptoListViewModel.cryptoList = []
                        await cryptoListViewModel.downloadCrytosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                }
                label :{
                    Text("Refresh")
                }
            })
            
            .navigationTitle("Crypto Crazy")
        }.task {
            await cryptoListViewModel.downloadCrytosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
            //await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        
        /*
        .onAppear {
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
