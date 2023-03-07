//
//  productionCompaniesViewCell.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 06/03/23.
//

import UIKit

class productionCompaniesViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCompanie: UIImageView!
    @IBOutlet weak var lblCompanie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(data: ProductionCompanies) {
        if let imagePath = data.logoPath, !imagePath.isEmpty {
            imgCompanie.loadFromUrl(url: baseUrl.image + imagePath)
        } else {
            imgCompanie.backgroundColor = UIColor(named: "PrincipalTop")
        }
        lblCompanie.text = data.name
    }
}
