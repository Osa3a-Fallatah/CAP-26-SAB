//
//  DataBaseFile.swift
//  SAB-Cars
//
//  Created by Osama folta on 30/05/1443 AH.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserInfo{
    static var shared: UserInfo = UserInfo()
    let db = Database.database().reference()
    let dbStore = Firestore.firestore()
    var cars = [Car]()
    func getUserName(complation: @escaping (User)->Void){
        dbStore.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { snapshot, err in
                do{
                    var user = User()
                    guard let snapshot = snapshot?.documents else { return }
                    user = try snapshot.first!.data(as:User.self)!
                    complation(user)
                }catch{
                    print(err!.localizedDescription)
                }
                
            }
        
    }
    func getCars(complation: @escaping (Car)->Void){
        dbStore.collection("Cars")
        .addSnapshotListener { (querySnapshot, err) in
            if  err != nil {
                
                print("Error getting documents: \(err!)")
            } else {
               
                self.cars.removeAll()
                for document in querySnapshot!.documents {
                    let carObj = try! document.data(as: Car.self)
                    self.cars.append(carObj!)
                    complation(carObj!)
                }
                
            }
        }
    }
}
