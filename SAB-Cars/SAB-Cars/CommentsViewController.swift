//
//  CommentsViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 14/05/1443 AH.
//
import FirebaseFirestore
import Firebase
import FirebaseMessaging
import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
      @IBOutlet weak var textField: UITextField!
    var chatRoom = ""
    
    fileprivate func deleteMessage() {
        let alert = UIAlertController(title: " Are You Sure", message: "This action deletes all messages", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler:{(action) in
            Database.database().reference().child("Comments").child(self.chatRoom).removeValue()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clearChat(_ sender: UIBarButtonItem) {
        let dbStore = Firestore.firestore().collection("Cars")
        
        dbStore.getDocuments { snapshot, error in
            for doc in snapshot!.documents {
                let carDoc = doc.data() as! [String: Any]
                if let uid = carDoc["userID"] as? String {
                    if (Auth.auth().currentUser?.uid == uid) {
                        print ("Can Delete")
                        self.deleteMessage()
                    }
                }
            }
        }

    }
    @IBAction func sendButton(_ sender: Any) {
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            design.useAlert(title: "", message: "no text", vc: self)
        } else{ sendMsg() }
    }
    var dbStore = Firestore.firestore().collection("users")
    let ref=Database.database().reference().child("Comments")
    var messages = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readMsgs()
        // Do any additional setup after loading the view.
            
    }
    func sendMsg(){
    
        dbStore.whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { snapshot, err in
                guard let snapshot = snapshot else { return }
                let data = snapshot.documents.first!.data()
                let fname = data["firstName"] as! String
                let lname = data["lastName"] as! String
                let fullname = fname + " " + lname
            
               let liveChat2=Comment(id: fullname, date: "\(Date.now.formatted(.dateTime))", message: self.textField.text!)
                //let liveChat=["id":fullname , "message":self.textField.text!, "date": Date.now.formatted(.dateTime)]
               // self.ref.child(self.chatRoom).childByAutoId().setv {(error,refernce)in
                self.ref.child(self.chatRoom).childByAutoId().setValue(liveChat2){(error,refernce)in
            if error != nil{
                design.useAlert(title: "error", message: error!.localizedDescription, vc: self)
            }
        }
    }
    }
    func readMsgs(){
      
        ref.child(chatRoom).observe(.childAdded) { snapshot in
            let result=snapshot.value as! Dictionary<String,String>
            let id=result["id"]!
            let msg=result["message"]!
            let date=result["date"]!
            let package=Comment(id: id, date: date, message: msg)
            
            self.messages.append(package)
            self.tableview.reloadData()
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}


extension CommentsViewController :UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        cell.lableForName.text = messages[indexPath.row].id
        cell.lablForText.text = messages[indexPath.row].message
        cell.lableForDate.text = messages[indexPath.row].date
        
        cell.viewshap.layer.cornerRadius = 20
        return cell
    }
    
}



