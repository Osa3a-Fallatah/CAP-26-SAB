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
    var photo=""
    
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
                let carDoc = doc.data() 
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
        tableview.register(UINib(nibName: "CarImageTVC", bundle: nil), forCellReuseIdentifier: "bannerid")
    }
    func sendMsg(){
    
        dbStore.whereField("uid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { snapshot, err in
                guard let snapshot = snapshot else { return }
                let data = snapshot.documents.first!.data()
                let fname = data["firstName"] as! String
                let lname = data["lastName"] as! String
                let fullname = fname + " " + lname
            
              // let liveChat2=Comment(id: fullname, date: "\(Date.now.formatted(.dateTime))", message: self.textField.text!)
                let liveChat=["id":fullname , "message":self.textField.text!, "date": Date.now.formatted(.dateTime)]
               self.ref.child(self.chatRoom).childByAutoId().setValue(liveChat){(error,refernce)in
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
                let indexPath = IndexPath(row: self.messages.count - 1, section: 1)
                self.tableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}


extension CommentsViewController :UITableViewDelegate ,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return 1}
        else{
            return  messages.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
     let  cell = tableView.dequeueReusableCell(withIdentifier: "bannerid", for: indexPath) as! CarImageTVC
            let imageURL = URL(string:photo)!
            URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                if (error == nil) {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        cell.bigImage.image = UIImage(data: data)
                    }
                }
            }.resume()
       return cell
    }
        else{
        let cell = tableview.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        let comment = messages[indexPath.row]
        
        cell.setData(name: comment.getid(), msg: comment.getmessage(), date: comment.getdate())
        cell.viewshap.layer.cornerRadius = 20
        return cell
    }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
        return 250
        }else{
            return 120
        }
    }
}



