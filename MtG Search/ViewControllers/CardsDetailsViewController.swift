//
//  CardsDetailsViewController.swift
//  MtG Search
//
//  Created by Arkow on 15/07/2022.
//

import UIKit
import AlamofireImage

final class CardsDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var card: Card?
    
    // MARK: - Subviews
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var manaCostLabel: UILabel!
    @IBOutlet weak var typeLineLabel: UILabel!
    @IBOutlet weak var oracleLineLabel: UILabel!
    @IBOutlet weak var addToWantViewButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let card = card else { return }
        

            cardNameLabel.text = card.name
            cardImageView.af.setImage(withURL: card.imageUrls.small)
            manaCostLabel.text = card.manaCost
            typeLineLabel.text = card.typeLine
            oracleLineLabel.text = card.oracleText
            
            for produkt in BasketManager.shared.basket {
                if produkt.name == card.name {
                    addToWantViewButton.setTitle("ADDED", for: .normal)
                    addToWantViewButton.backgroundColor = .darkGray
            }
        }
    }
    
    // MARK: - Methods

    @IBAction func didTapAddToWantButton(_ sender: Any) {
        guard let card = card else { return }
        BasketManager.shared.addToBasket(value: card)
        
        addToWantViewButton.setTitle("ADDED", for: .normal)
        addToWantViewButton.backgroundColor = .darkGray
    }
}
