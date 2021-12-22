//
//  DataDelegate.swift
//  GETFilms
//
//  Created by admin on 22/12/2021.
//

import Foundation

protocol DataDelegate: AnyObject {
    func gettingPeople(peopleList: [String])
    func gettingFilms(filmsList: [String])
}
