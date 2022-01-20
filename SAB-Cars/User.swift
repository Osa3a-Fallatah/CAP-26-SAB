//
//  User.swift
//  SAB-Cars
//
//  Created by Osama folta on 09/05/1443 AH.
//

import FirebaseFirestoreSwift


struct User:Codable {
    var uid = String ()
    var firstName = String ()
    var lastName = String ()
    var phoneNumber = Int ()
    var showPhone = false
    
}
