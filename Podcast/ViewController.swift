//
//  ViewController.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

//TODO: you cannot use spaces in the search, the ALERT shows up when you type space and/or special characters. use .addingPercentEncoding with .urlHostAllowed in the with AllowedCharacters:

import UIKit

class ViewController: UIViewController {
    
    //the user types something eg. "R" , the userQuery is set to whatever the user inputs into the searchbar. the getPodcasts() queries the API based on the userQuery. Then it will bring up everything thats has R in it. then you set your podcastRef(variable reference) = equal to the data that the escaping closure has captured
    var podcastRef = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.podcastTableView.reloadData()
            }
        }
    }
    
    var userQuery = "" {
        didSet {
            ApplePodcast.getPodcasts(for: userQuery) { [weak self] (result) in
                switch result { //we need
                case .failure(let appError)://dispatchqueue excutes on the main thread or background thread
                    DispatchQueue.main.async {//anything that is a property or a method use SELF in DispatchQueue
                        self?.showAlert(title: "Data Failure", message: "Unable to retrieve that podcast, Please do not use special characters, \(appError)")//self.so not in the 3d person
                    }
                case .success(let data):
                    self?.podcastRef = data
                }
            }
        }
    }
    
    @IBOutlet weak var podcastTableView: UITableView!
    @IBOutlet weak var podcastSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        podcastTableView.dataSource = self
        podcastSearch.delegate = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = podcastTableView.indexPathForSelectedRow,
            let eachCellToDVC = segue.destination as? DetailViewController else { fatalError("could not segue")}
        let cell = podcastRef[indexPath.row]
        eachCellToDVC.modelReference = cell
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcastRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = podcastTableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastTableViewCell else { fatalError("could not get data")}
        
        cell.podcastLabel.text = podcastRef[indexPath.row].collectionName
        cell.podcastNameLabel.text = podcastRef[indexPath.row].trackName
        //in order to access the enumeration's associated values is by using a switch statement
        ApplePodcast.getImagesFromAPI(for: podcastRef[indexPath.row].artworkUrl60) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Image Error" , message: "Image Not Found \(appError)")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    cell.podcastImage.image = image
                }
            }
        }
        return cell
    }
    
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userQuery = searchText
        
    }
}


