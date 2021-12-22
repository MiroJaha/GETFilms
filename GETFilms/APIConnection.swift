//
//  APIConnection.swift
//  GETFilms
//
//  Created by admin on 22/12/2021.
//

import Foundation
import UIKit

class APIConnection {
    
    weak var dataDelegate: DataDelegate?
    
    var peopleList = [String]()
    var filmsList = [String]()

    func gettingPeopleFromAPI(pageNumber: Int) {
        peopleList.removeAll()
        // specify the url that we will be sending the GET Request to
        let url = URL(string: "https://swapi.dev/api/people/?page=\(pageNumber)&format=json")
        // create a URLSession to handle the request taskscopy
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        // coercing the results object as an NSArray and then storing that in resultsArray
                        let resultsArray = results as! NSArray
                        // now we can run NSArray methods like count and firstObject
                        for result in resultsArray {
                            if let data = result as? NSDictionary {
                                if let result = data["name"] {
                                    let name = result as! String
                                    self.peopleList.append(name)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.dataDelegate?.gettingPeople(peopleList: self.peopleList)
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()
    }
    
    func gettingFilmsFromAPI() {
        filmsList.removeAll()
        // specify the url that we will be sending the GET Request to
        let url = URL(string: "https://swapi.dev/api/films/?format=json")
        // create a URLSession to handle the request taskscopy
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        // coercing the results object as an NSArray and then storing that in resultsArray
                        let resultsArray = results as! NSArray
                        // now we can run NSArray methods like count and firstObject
                        for result in resultsArray {
                            if let data = result as? NSDictionary {
                                if let result = data["title"] {
                                    let name = result as! String
                                    self.filmsList.append(name)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.dataDelegate?.gettingFilms(filmsList: self.filmsList)
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()
    }
}
