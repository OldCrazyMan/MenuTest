//
//  MainView.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//

import Foundation

protocol MainView: NSObjectProtocol {
    func finishLoading()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MenuViewController,
         networkService: NetworkFetchProtocol)
    
    var mainCellViewModels: PizzaArray { get set }
    func getPizza()
}

class MainPresenter: MainViewPresenterProtocol  {
    
    weak var mainView: MainView?
    let networkService: NetworkFetchProtocol
    var mainCellViewModels = PizzaArray()
    
    required init(view: MenuViewController, networkService: NetworkFetchProtocol) {
        self.mainView = view
        self.networkService = networkService
        getPizza()
    }
    
    func getPizza() {
        networkService.fetchPizza { [weak self] data, error in
            guard let self = self else { return }
            
            if error != nil {
                print("MainVC NetworkDataFetch error:\(String(describing: error?.localizedDescription))")
            } else {
                guard let data = data else { return }
                self.mainCellViewModels = data
                mainView?.finishLoading()
            }
        }
    }
}
