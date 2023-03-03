//
//  DogBreedCellItem.swift
//  fetchFreeApi
//
//  Created by Anton Honcharov on 02.03.2023.
//

import UIKit

@objc protocol CellItemProtocol: NSObjectProtocol {
    func onCellPress(_ cell: DogBreedCellItem)
}

class DogBreedCellItem: UITableViewCell {
    // MARK: - Props
    static let cellID = "DogBreedCellID";
    
    // MARK: - Outlets
    @IBOutlet weak var breedName: UILabel!
    
}

// MARK: - Lifecycle
extension DogBreedCellItem {
    override class func awakeFromNib() {}
}
// MARK: - Setup
extension DogBreedCellItem {
    func configure(with breedTitle: String) {
        breedName.text = breedTitle;
    }
}
