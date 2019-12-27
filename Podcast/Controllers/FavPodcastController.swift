//
//  FavPodcastViewController.swift
//  Podcast
//
//  Created by Melinda Diaz on 12/17/19.
//  Copyright © 2019 Melinda Diaz. All rights reserved.
//

import UIKit

class FavPodcastController: UIViewController {
//TODO: get your favorites on this tableVIew
    //TODO: segue tableview to detailVC
    //TODO: make post button useless when already pressed
    var modelRef = [Podcast]()
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = favoriteTableView.indexPathForSelectedRow,
            let detailedTableView = segue.destination as? DetailViewController else {
                fatalError("Could not segue")}
        let eachCell = modelRef[indexPath.row]
        detailedTableView.modelReference = eachCell
    }

}

extension FavPodcastController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastTableViewCell else {fatalError("Could not find Cell")}
        
            
        }
    }
    
    
}
