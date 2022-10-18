//
//  WantList.swift
//  MtG Search
//
//  Created by Arkow on 17/07/2022.
//

import UIKit
import AlamofireImage

final class WantListViewController: UIViewController {
    
    // MARK: - Subviews
    
    @IBOutlet weak var wantListTableView: UITableView!

    // MARK: - Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.cardDetailsIdentifier {
            let destinationVC = segue.destination as! CardsDetailsViewController
            destinationVC.card = sender as? Card
        }
    }
}

extension WantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BasketManager.shared.basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wantListCell", for: indexPath) as? WantListTableViewCell else {
            return UITableViewCell()
        }
        
        let item = BasketManager.shared.basket[indexPath.row]
        cell.nameCardLabel.text = item.name
        cell.cardImageView.af.setImage(withURL: item.imageUrls.small)

        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let item = BasketManager.shared.basket[indexPath.row]
            BasketManager.shared.removeFromBasket(value: item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension WantListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(
            withIdentifier: Constants.cardDetailsIdentifier,
            sender: Array(BasketManager.shared.basket)[indexPath.row]
        )
    }
}

extension WantListViewController {
    enum Constants {
        static let cardDetailsIdentifier: String = "cardDetailsFromWant"
    }
}
