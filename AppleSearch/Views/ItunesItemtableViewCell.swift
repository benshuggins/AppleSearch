//
//  ItunesItemtableViewCell.swift
//  AppleSearch
//
//  Created by Ben Huggins on 2/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ItunesItemtableViewCell: UITableViewCell {
    
    
    var itemLandingPad: ItunesItem? {
        
        didSet{
            updateViews()
        }
        
    }
    
    func updateViews() {
        guard let unwrappedItem = itemLandingPad else {return}
        artistNameLabel.text = unwrappedItem.artistName
        songNameLabel.text = unwrappedItem.songName
        albumNameLabel.text = unwrappedItem.albumName        
    }

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
  

}
