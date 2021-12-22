//
//  ViewController.swift
//  GETPeople
//
//  Created by admin on 21/12/2021.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var pageNumber = 1
    var peopleList = [String]()
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var pageNumberLabel: UILabel!
    
    let aPIConnection = APIConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check()
        aPIConnection.dataDelegate = self
        aPIConnection.gettingPeopleFromAPI(pageNumber: pageNumber)
        mainTableView.dataSource = self
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        pageNumber += 1
        pageNumberLabel.text = "Page: \(pageNumber)/9"
        check()
        aPIConnection.gettingPeopleFromAPI(pageNumber: pageNumber)
    }
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        pageNumber -= 1
        pageNumberLabel.text = "Page: \(pageNumber)/9"
        check()
        aPIConnection.gettingPeopleFromAPI(pageNumber: pageNumber)
    }
    func check() {
        if pageNumber == 9 {
            nextButton.isEnabled = false
        }else {
            nextButton.isEnabled = true
        }
        if pageNumber == 1 {
            previousButton.isEnabled = false
        }else {
            previousButton.isEnabled = true
        }
    }
    
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = peopleList[indexPath.row]
        return cell
    }
    
    
}

extension PeopleViewController: DataDelegate {
    func gettingPeople(peopleList: [String]) {
        self.peopleList = peopleList
        mainTableView.reloadData()
    }
    
    func gettingFilms(filmsList: [String]) {
        
    }
    
    
}
