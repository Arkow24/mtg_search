//
//  BasketManager.swift
//  MtG Search
//
//  Created by Arkow on 18/07/2022.
//

import UIKit

final class BasketManager {

    // MARK: - Properties
    
    static var shared: BasketManager = BasketManager()
    var basket: [Card] = []
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Methods
    
    func addToBasket(value: Card) {
        if basket.contains(where: {$0.name == value.name}) {} else {
            basket.append(value)
        }
    }

    func removeFromBasket(value: Card) {
        if basket.contains(where: {$0.name == value.name }){
            guard let removeItem = basket.firstIndex(of: value) else {return}
            basket.remove(at: removeItem)
        }
        }
}
