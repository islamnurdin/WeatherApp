//
//  WeatherCollectionViewCell.swift
//  iOSSecondTask
//
//  Created by MacBook Pro on 6/29/18.
//  Copyright © 2018 Islam & Co. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.shadowColor = UIColor.lightGray.cgColor
            cardView.layer.shadowRadius = 2
            cardView.layer.shadowOpacity = 1
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    
    @IBOutlet var dayCollection: UILabel!

    @IBOutlet weak var dayTemp: UILabel!
    
    @IBOutlet weak var nightTemp: UILabel!
        
    
}
