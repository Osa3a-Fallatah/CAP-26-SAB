//
//  DataBaseFile.swift
//  SAB-Cars
//
//  Created by Osama folta on 30/05/1443 AH.
//

import Firebase
import FirebaseStorage
import FirebaseMessaging
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
                    guard let snapshot = snapshot else { return }
                    let data = snapshot.documents.first!.data()
                    let FN = (data["firstName"]!) as! String
                    let LN = (data["lastName"]!) as! String
                    user.firstName = FN
                    user.lastName = LN
                    complation(user)
                }catch{
                    print(err?.localizedDescription)
                }
                
            }
        
    }
    func getCars(complation: @escaping (Car)->Void){
        dbStore.collection("Cars")
        .addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                
                print("Error getting documents: \(err)")
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
