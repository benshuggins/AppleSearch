//
//  ItunesItemViewController.swift
//  AppleSearch
//
//  Created by Ben Huggins on 2/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ItunesItemViewController: UIViewController {
    
    var itunesItems: [ItunesItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
         searchBar.delegate = self
    }
    
}
extension ItunesItemViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itunesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itunesCell", for: indexPath) as? ItunesItemtableViewCell
        
        let itunesItem = itunesItems[indexPath.row]
        
        cell?.itemLandingPad = itunesItem
        ItunesItemController.fetchImageFor(item: itunesItem) { (image) in
        
            DispatchQueue.main.async {
            
                cell?.albumImageView.image = image
        }

        }
//        cell?.albumNameLabel.text = itunesItem.albumName
//        cell?.artistNameLabel.text = itunesItem.artistName
//        cell?.songNameLabel.text = itunesItem.songName
        
        
        return cell ?? UITableViewCell()
    }
    
}
extension ItunesItemViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        ItunesItemController.fetchItunesItemsFor(searchTerm: searchTerm) { (items) in
            self.itunesItems = items
        }
    }
}
