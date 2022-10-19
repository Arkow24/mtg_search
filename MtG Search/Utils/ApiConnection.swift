////
////  ApiConnection.swift
////  MtG Search
////
////  Created by Arkow on 10/08/2022.
////
//
//import Foundation
//import UIKit
//





//final class ApiConnction {
//
//    // MARK: - Properties
//
//    private let session: URLSession = .shared
//   // private let baseUrl: String = Constants.baseURL
//   //  let modyfiQuery = query.replacingOccurrences(of: " ", with: "+")
//    static let shared: ApiConnction = .init()
//
//    // MARK: - Methods
//
//    func getDate(for query: String) {
//        let modyfiQuery = query.replacingOccurrences(of: " ", with: "+")
//        guard let cardUrl = URL(string: "https://api.scryfall.com/cards/search?q=\(modyfiQuery)&format=json") else {return}
//
//
//        let task = session.dataTask(with: cardUrl) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let dataAll = try? decoder.decode(DataAll.self, from: data) {
////                    self.cardTab = dataAll?.data ?? []
////                    self.collectionView.reloadData()
//                }
//            }
//        }
//        task.resume()
//    }
//
//}
