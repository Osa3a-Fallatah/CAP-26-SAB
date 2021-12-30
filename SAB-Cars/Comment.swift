//
//  Comment.swift
//  SAB-Cars
//
//  Created by Osama folta on 16/05/1443 AH.
//
import FirebaseAuth
import FirebaseFirestoreSwift
import Foundation

struct Comment :Codable{
    var sender :String=""
    var date : String=""
    var message:String=""
    //    var commentOn:Car
    func getid()->String{
        sender
    }
    func getmessage()->String{
        message
    }
    func getdate()->String{
        date
    }
 
}
