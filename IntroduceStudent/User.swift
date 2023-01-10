//
//  User.swift
//  IntroduceStudent
//
//  Created by Pei Qi Tea on 10/1/23.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var schoolName: String
    var academicYear: String
    var numberOfPets: Int
    var morePets: Bool
}
