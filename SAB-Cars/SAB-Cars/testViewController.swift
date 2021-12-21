//
//  testViewController.swift
//  SAB-Cars
//
//  Created by Osama folta on 17/05/1443 AH.
//

import UIKit

class testViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var textout: UITextField!
    var num=["aa" , "bb" , "cc" , "dd"]
    var arr=["mom","dad"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         num.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textout.text! = num[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return num[row]
    }

   var multichoes = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        multichoes.delegate=self
        multichoes.dataSource=self
        textout.inputView = multichoes
        // Do any additional setup after loading the view.
        
     //view.endEditing(true)
    }
    func getimage(){
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/sab-cars-app.appspot.com/o/%E2%80%8F%D9%84%D9%82%D8%B7%D8%A9%20%D8%A7%D9%84%D8%B4%D8%A7%D8%B4%D8%A9%20%D9%A1%D9%A4%D9%A4%D9%A3-%D9%A0%D9%A5-%D9%A1%D9%A1%20%D9%81%D9%8A%20%D9%A8.%D9%A3%D9%A0.%D9%A3%D9%A2%C2%A0%D9%85.png?alt=media&token=653b8a4a-5dd2-43ec-9a6e-b4ea4606acda")
        URLSession.shared.dataTask(with: url!) { (data, _, err) in
            if err == nil{
                guard let data = data  else { return }
                print(data)
                DispatchQueue.main.async {
                    self.tabBarItem.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
