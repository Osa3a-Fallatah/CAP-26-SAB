//
//  Model.swift
//  SAB-Cars
//
//  Created by Osama folta on 09/05/1443 AH.
//

import Foundation

struct User {
    var username:String
    var phoneNumber:Int
    var cars:[Car]
    
}

class Car {
    //var id:Int
    var brand:String=""
    var gasType :String=""
    var gearbox:String=""
    var location:String=""
    var status:String=""
    var year:String=""
    var price:String=""
}

struct Comment{
    var id :String
    var date:Date
    var message:String
    var commentOn:Car
    var commentBy:User
}
