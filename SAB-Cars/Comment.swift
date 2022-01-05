//
//  Comment.swift
//  SAB-Cars
//
//  Created by Osama folta on 16/05/1443 AH.
//
import FirebaseFirestoreSwift

struct Comment :Codable{
    var sender :String=""
    var date : String=""
    var message:String=""
    var id:String=""
    var userID:String=""
    
    func getUserID()->String{
        userID
    }
    func getId()->String{
        id
    }
    func getSender()->String{
        sender
    }
    func getmessage()->String{
        message
    }
    func getdate()->String{
        date
    }
    
}
