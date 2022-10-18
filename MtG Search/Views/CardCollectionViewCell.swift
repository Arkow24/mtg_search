//
//  CardCollectionViewCell.swift
//  MtG Search
//
//  Created by Arkow on 15/07/2022.
//


import UIKit

final class CardCollectionViewCell: UICollectionViewCell {

    // MARK: - Subviews
    
    @IBOutlet weak var nameCardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var addToWantListButton: UIButton!
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addToWantListButton.setTitle("ADD", for: .normal)
        addToWantListButton.backgroundColor = .lightGray
        addToWantListButton.enumerateEventHandlers { action, _, event, _ in
            if let action = action {
                addToWantListButton.removeAction(action, for: event)
            }
        }
    }
    
    func setupSelectedView() {
        addToWantListButton.setTitle("DONE", for: .normal)
        addToWantListButton.backgroundColor = .darkGray
    }
}
