//
//  User.swift
//  SAB-Cars
//
//  Created by Osama folta on 09/05/1443 AH.
//

import FirebaseFirestoreSwift
import Foundation

class User:Codable {
    var username:String=""
    var phoneNumber:Int=0
    var gender:String=""
    var cars:[Car]=[]
}
