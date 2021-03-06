//
//  Car.swift
//  SAB-Cars
//
//  Created by Osama folta on 16/05/1443 AH.
//


import FirebaseFirestoreSwift

struct Car : Codable {
    @DocumentID var id:String? = String()
    var brand = String()
    var gasType = String()
    var kilometeRreading = Int()
    var gearbox = String()
    var location = String()
    var status = String()
    var year = String()
    var price = Int()
    var carImage = String()
    var userID = String()
}
