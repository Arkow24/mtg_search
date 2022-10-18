//
//  SearchViewController.swift
//  MtG Search
//
//  Created by Arkow on 15/07/2022.
//

import UIKit
import AlamofireImage

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    var cardTab: [Card] = []
    
    // MARK: - Subviews
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wantListMainButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.cardDetailsIdentifier {
            let destinationVC = segue.destination as! CardsDetailsViewController
            destinationVC.card = sender as? Card
        }
    }

    @IBAction func didTextChange(_ sender: Any) {
        searchCards(for: searchTextField.text ?? "")
    }
    
    // MARK: - Private methods
    
    

    private func searchCards(for query: String) {
        // APICLIENT
        let modyfiQuery = query.replacingOccurrences(of: " ", with: "+")
        let cardUrl = URL(string: "https://api.scryfall.com/cards/search?q=\(modyfiQuery)&format=json")!
        
        
        let task = URLSession.shared.dataTask(with: cardUrl) { data, response, error in
            if let error1 = error {
                print(error1)
                return
            }
            if let data = data {
                let dataAll = try? JSONDecoder().decode(DataAll.self, from: data)
                DispatchQueue.main.async {
                    self.cardTab = dataAll?.data ?? []
                    self.collectionView.reloadData()
                }
            }
        }
        task.resume()
    }
}



extension SearchViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return cardTab.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cardCell",
            for: indexPath
        ) as? CardCollectionViewCell
        else { return UICollectionViewCell() }
        
        let card = self.cardTab[indexPath.item]
        for product in BasketManager.shared.basket {
            if product.name == self.cardTab[indexPath.item].name {
                cell.setupSelectedView()
            }
        }
        
        cell.nameCardLabel.text = cardTab[indexPath.item].name
        cell.cardImageView.af.setImage(withURL: cardTab[indexPath.item].imageUrls.small)
        cell.addToWantListButton.actionHandler(controlEvents: .touchUpInside) {
        BasketManager.shared.addToBasket(value: card)
        cell.setupSelectedView()
        }
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.cardDetailsIdentifier, sender: cardTab[indexPath.item])
    }
}

extension SearchViewController {
    enum Constants {
        static let cardDetailsIdentifier: String = "cardDetails"
    }
}
