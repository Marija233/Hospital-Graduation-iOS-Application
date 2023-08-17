//
//  ViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 9/3/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController {

    @IBOutlet weak var belaSlika1: UIImageView!
    
    @IBOutlet weak var belaSlika2: UIImageView!
    
    @IBOutlet weak var zdravstvoTekst: UILabel!
    @IBOutlet weak var srce: UIImageView!
    
    @IBOutlet weak var blankField: UIImageView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    
    var signUpMode = true
    var refRequests: DatabaseReference!
    @IBOutlet weak var ime: UITextField!
    
    @IBOutlet weak var prezime: UITextField!
    
    @IBOutlet weak var dejnost: UITextField!
    
    
    @IBOutlet weak var slikaUser: UIImageView!
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
              // Do any additional setup after loading the view.
        
     self.view.addSubview(HorizontalView(frame: self.view.bounds))
        self.view.addSubview(belaSlika1)
        self.view.addSubview(belaSlika2)
        
        self.view.addSubview(srce)
        self.view.addSubview(zdravstvoTekst)
        self.view.addSubview(blankField)
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: view.frame.height - 1, width: view.frame.width, height: 1.0)
        bottomLine.backgroundColor =   UIColor(red: 0.20, green: 0.53, blue: 0.94, alpha: 1.00).cgColor
        email.borderStyle = UITextField.BorderStyle.none
        email.layer.addSublayer(bottomLine)
        email.setUnderLine()
        
        password.borderStyle = UITextField.BorderStyle.none
        password.layer.addSublayer(bottomLine)
        password.setUnderLine()
        
        self.view.addSubview(email)
        self.view.addSubview(password)
        
        topButton.layer.cornerRadius = 6
        topButton.clipsToBounds = true
        
        dejnost.borderStyle = UITextField.BorderStyle.none
        dejnost.layer.addSublayer(bottomLine)
        dejnost.setUnderLine()
        
        ime.borderStyle = UITextField.BorderStyle.none
        ime.layer.addSublayer(bottomLine)
        ime.setUnderLine()
        
        prezime.borderStyle = UITextField.BorderStyle.none
        prezime.layer.addSublayer(bottomLine)
        prezime.setUnderLine()
        
        
        
       // slikaUser.layer.cornerRadius = 20  staro
        slikaUser.layer.masksToBounds = false
        slikaUser.layer.borderWidth = 1
        slikaUser.layer.cornerRadius = slikaUser.frame.height/2
        slikaUser.layer.borderColor = UIColor.init(red: 0.20, green: 0.53, blue: 0.94, alpha: 1.00).cgColor
        slikaUser.clipsToBounds = true // i ova e staro
        
        slikaUser.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        slikaUser.addGestureRecognizer(tapGesture)
        
        
        self.view.addSubview(topButton)
        self.view.addSubview(bottomButton)
        self.view.addSubview(dejnost)
        self.view.addSubview(ime)
        self.view.addSubview(prezime)
        
        
        
        self.view.addSubview(slikaUser)
        
  
        
         if !signUpMode {
                   bottomButton.setTitle("Креирај сметка", for: .normal)
                   topButton.setTitle("Најава", for: .normal)
                   ime.isHidden = true
                   prezime.isHidden = true
                   dejnost.isHidden = true
               } else {
                   topButton.setTitle("Креирај сметка", for: .normal)
                   bottomButton.setTitle("Најава", for: .normal)
                   ime.isHidden = false
                   prezime.isHidden = false
                   dejnost.isHidden = false
               }
        
    }
        
    @IBAction func signupTapped(_ sender: Any) {
        
  /*
        */
        
        
        if email.text == "" && password.text == "" {
            displayAlert(title: "Недостасуваат податоци", message: "Внеси ги сите потребни податоци за регистрација.")
        } else {
            if let email = email.text {
                if let password = password.text {
                    
                    if signUpMode {
                
                        // SIGN UP
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Грешка при регистрација!", message: error!.localizedDescription)
                            } else {
                                print("Uspesna registracija.")
                                if  self.dejnost.text?.lowercased() == "doktor" || self.dejnost.text?.lowercased() == "доктор" || self.dejnost.text?.lowercased() == "doctor" {
                                    
                                guard let imageSelected = self.image else {
                                                              print("nil")
                                                              return
                                                      }
                                                      guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                                                          return
                                                      }
                                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                    
                                  
                                     req?.photoURL = URL(string: "Doktor")
                                    print("Se registrirase Dr. " + self.prezime.text!)
                                    
                                     req?.displayName =  self.ime.text! + " " + self.prezime.text!
                                    
                      let storageRef = Storage.storage().reference(forURL: "gs://gradapp-a9944.appspot.com")
                                    
                                    
                         self.refRequests = Database.database().reference().child("Doktor")
                                                                                                                                                                                 
                                    let key = self.refRequests.childByAutoId().key
                                    
                                   
                                    let storageProfileRef = storageRef.child("profile").child(key!)
                                    
                                    let metadata = StorageMetadata()
                                    metadata.contentType = "image/jpeg"
                                    
                                    storageProfileRef.putData(imageData, metadata: metadata, completion: { (storageMetaData, error) in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                            return
                                        }
                                        
                                        storageProfileRef.downloadURL(completion: {(url, error) in
                                            if let metaImageUrl = url?.absoluteString
                                            {
                                               
                                                 
                                                
                                                
                                                
                                                
                                                let dict = ["id":key, "email": Auth.auth().currentUser?.email, "fullName": req?.displayName, "role": req?.photoURL?.absoluteString, "specialty": "" , "profileImageUrl" : metaImageUrl, "sum" :"0",  "NoOfRaters" : "0" , "about": ""] as [String : Any]
                                                
                                                
                                                self.refRequests.child(key!).setValue(dict)
                                                
                                            }
                                        })
                                    })
                                    
                                    
                                    
                                                                                                             
                                //  let dict = ["id":key, "email": Auth.auth().currentUser?.email, "fullName": req?.displayName, "role": req?.photoURL?.absoluteString, "specialty": "" , "profileImageUrl" : ""] as [String : Any]
                                                                                                                                                                                 
                                // self.refRequests.child(key!).setValue(dict)
                                    
                                    
                                    req?.commitChanges(completion: nil)
                                  //  self.performSegue(withIdentifier: "doctorSegue", sender: nil)
                                } else if self.dejnost.text?.lowercased() == "pacient" || self.dejnost.text?.lowercased() == "пациент" || self.dejnost.text?.lowercased() == "patient" {
                                    
                                     guard let imageSelected = self.image else {
                                                print("nil")
                                                return
                                                                                       }
                                    guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                                                return
                                }
                                    
                                    
                                    
                                  
                                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                    req?.displayName = self.ime.text! + " " + self.prezime.text!
                                    
                                         let storageRef = Storage.storage().reference(forURL: "gs://gradapp-a9944.appspot.com")
                                    
                                    
                                    
                                    req?.photoURL = URL(string : "Pacient" )
                                    
                                      print("Se registrirase pacientot " + self.ime.text! + " " + self.prezime.text!)
                                    
                                         self.refRequests = Database.database().reference().child("Pacient")
                                                                                                                                              
                                    let key = self.refRequests.childByAutoId().key
                                    
                                     let storageProfileRef = storageRef.child("profile").child(key!)
                                                                       
                                                                       let metadata = StorageMetadata()
                                                                       metadata.contentType = "image/jpeg"
                                                                       
                                                                       storageProfileRef.putData(imageData, metadata: metadata, completion: { (storageMetaData, error) in
                                                                           if error != nil {
                                                                               print(error?.localizedDescription)
                                                                               return
                                                                           }
                                                                           
                                                                           storageProfileRef.downloadURL(completion: {(url, error) in
                                                                               if let metaImageUrl = url?.absoluteString
                                                                               {
                                                                                  
                                                                                    
                                                                                   
                                                                                   
                                                                                   
                                                                                   
                                                                                let dict = ["id":key, "email": Auth.auth().currentUser?.email, "fullName": req?.displayName, "role": req?.photoURL?.absoluteString, "profileImageUrl": metaImageUrl] as [String : Any]
                                                                                   
                                                                                   
                                                                                   self.refRequests.child(key!).setValue(dict)
                                                                                   
                                                                               }
                                                                           
                                                                    
                                                                           })
                                                                       
                                                                       })
                                                                       
                                    
                                    
                                                                                                              
                                                                          
                                  //  let dict = ["id":key, "email": Auth.auth().currentUser?.email, "fullName": req?.displayName, "role": req?.photoURL?.absoluteString] as [String : Any]
                                                                                                                                              
                                  //  self.refRequests.child(key!).setValue(dict)
                                    
                                    req?.commitChanges(completion: nil)
                                    self.performSegue(withIdentifier: "patientSegue", sender: nil)
                                }
                                else
                                {
                                     
                            let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                req?.displayName = self.ime.text! + " " + self.prezime.text!
                                     
                                    req?.photoURL = URL(string : "Administrator" )
                                                                    
                                    print("Se registrirase administratorot " + self.ime.text! + " " + self.prezime.text!)
                                    req?.commitChanges(completion: nil)
                                    
                                    self.performSegue(withIdentifier: "adminSegue", sender: nil)
                                    
                                    
                                }
                            }
                        }
                    } else {
                        // LOG IN
                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Грешка при најава", message: error!.localizedDescription)
                            } else {
                                print("Uspesna najava")
                                if  user?.user.photoURL?.absoluteString.lowercased() ==   "доктор" || user?.user.photoURL?.absoluteString.lowercased() == "doctor" || user?.user.photoURL?.absoluteString.lowercased() == "doktor" {
                                    print("Se najavi Dr. " + self.prezime.text!)
                                    self.performSegue(withIdentifier: "doctorSegue", sender: nil)
                                } else if user?.user.photoURL?.absoluteString.lowercased() == "пациент" || user?.user.photoURL?.absoluteString.lowercased() == "patient" || user?.user.photoURL?.absoluteString.lowercased() == "pacient" {
                                    print("Se najavi pacientot " + self.ime.text! + " " + self.prezime.text!)
                                    self.performSegue(withIdentifier: "patientSegue", sender: nil)
                                }
                                else
                                {
                                    print("Se najavi administratorot " + self.ime.text! + " " + self.prezime.text! )
                                    
                                    self.performSegue(withIdentifier: "adminSegue", sender: nil)
                                    
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func bottomButtonTapped(_ sender: Any) {
        if signUpMode
        {
             
            
            bottomButton.setTitle("Креирај сметка", for: .normal)
            topButton.setTitle("Најава", for: .normal)
          
            ime.isHidden = true
            dejnost.isHidden = true
            prezime.isHidden = true
            slikaUser.isHidden = true
            
            signUpMode = false
            
            
        }
            
        else
        {
           
            
            topButton.setTitle("Креирај сметка", for: .normal)
            bottomButton.setTitle("Најава", for: .normal)
          
            
             ime.isHidden = false
             prezime.isHidden = false
             dejnost.isHidden = false
            
            slikaUser.isHidden = false
             
            signUpMode = true
            
        }
        
        
    }
    
    
     func displayAlert(title: String, message: String) {
           let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alerController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alerController, animated: true, completion: nil)
       }
    
    
    @objc func presentPicker()
    {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated:true, completion:nil)
        
    }
    
    
}


class HorizontalView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        
        
        
        
        let topRect = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height/2)
      //  UIColor.blue.set()
         UIColor(red: 0.20, green: 0.53, blue: 0.94, alpha: 1.00).set()
       // UIColor(red: 0.33, green: 0.58, blue: 0.89, alpha: 1.00).set()
        guard let topContext = UIGraphicsGetCurrentContext() else { return }
              topContext.fill(topRect)

        let bottomRect = CGRect(x:0, y: rect.size.height/2, width: rect.size.width, height: rect.size.height/2)
             // UIColor.gray.set()
        UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00).set()
        guard let bottomContext = UIGraphicsGetCurrentContext() else { return }
              bottomContext.fill(bottomRect)    }
}


extension UITextField {

    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.init(red: 0.20, green: 0.53, blue: 0.94, alpha: 1.00).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}





extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            slikaUser.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            slikaUser.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
