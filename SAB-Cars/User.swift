//
//  User.swift
//  SAB-Cars
//
//  Created by Osama folta on 09/05/1443 AH.
//

import FirebaseFirestoreSwift
import Foundation

struct User:Codable {
    var uid:String=""
    var firstName:String=""
    var lastName:String=""
    var phoneNumber:Int=0
    var showPhone=false
}
