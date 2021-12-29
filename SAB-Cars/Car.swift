//
//  Car.swift
//  SAB-Cars
//
//  Created by Osama folta on 16/05/1443 AH.
//
import FirebaseFirestoreSwift
import Foundation
import UIKit

struct Car : Codable{
    @DocumentID var id:String?=""
    var brand:String=""
    var gasType :Int=0
    var gearbox:String=""
    var location:String=""
    var status:String=""
    var year:String=""
    var price:String=""
    var carImage:String=""
    var userID:String=""
    var comments: [Comment]? = []
    
    
    mutating func addComment(newComment: Comment){
        comments?.append(newComment)
       }
}
