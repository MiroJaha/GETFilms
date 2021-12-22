//
//  FilmsViewController.swift
//  GETFilms
//
//  Created by admin on 22/12/2021.
//

import UIKit

class FilmsViewController: UIViewController {

    var filmsList = [String]()
    @IBOutlet weak var mainTableView: UITableView!
    
    let aPIConnection = APIConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aPIConnection.dataDelegate = self
        aPIConnection.gettingFilmsFromAPI()
        mainTableView.dataSource = self
    }
}

extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell", for: indexPath)
        cell.textLabel?.text = filmsList[indexPath.row]
        return cell
    }
}

extension FilmsViewController: DataDelegate {
    func gettingPeople(peopleList: [String]) {
        
    }
    
    func gettingFilms(filmsList: [String]) {
        self.filmsList = filmsList
        mainTableView.reloadData()
    }
}
