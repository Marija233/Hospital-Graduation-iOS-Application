//
//  DoctorsSpecialistsDataViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/11/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit

import FirebaseAuth

import FirebaseDatabase


class DoctorsSpecialistsDataViewController: UIViewController {

    @IBOutlet weak var labl: UILabel!
    
    @IBOutlet weak var labelSpecialty: UILabel!
    
    @IBOutlet weak var labelReview: UILabel!
    
    @IBOutlet weak var labelNoOfRaters: UILabel!
    
    @IBOutlet weak var slikaDr: UIImageView!
    
    @IBOutlet weak var slikaPlava: UIImageView!
    
    @IBOutlet weak var labelAbout: UILabel!
    
    @IBOutlet weak var slikaBela: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var pomos: UILabel!
    
         var ref: DatabaseReference!
    var ref2: DatabaseReference!
    
    @IBOutlet weak var kopce: UIButton!
    
     var buttonHasBeenClicked = false
    
    var email = ""

    var name = ""

    var id = ""

    var specialty = ""

    var role = ""
    var sum = ""
    
    var NoOfRaters = ""
    
    var about = ""
    
    var profileImageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pomos.isHidden = true

        labl.text = "Dr. " + name
         slikaDr.layer.borderWidth = 1
               slikaDr.layer.cornerRadius = slikaDr.frame.height/2
               slikaDr.layer.borderColor = UIColor.init(red: 0.20, green: 0.53, blue: 0.94, alpha: 1.00).cgColor
               slikaDr.clipsToBounds = true
        
          let slikaUrl = URL(string: profileImageUrl)
              let slikaData = try! Data(contentsOf: slikaUrl!)
              slikaDr.image = UIImage(data: slikaData)
        
        labelSpecialty.text = specialty
        
        if NoOfRaters == "0"
        {
            labelReview.text = NoOfRaters + " " + "★"
            
        }
        else
        {
        labelReview.text = String(Int(sum)!/Int(NoOfRaters)!) + "★"
            
        }
        labelNoOfRaters.text =  NoOfRaters + " recenzii"
    
        self.view.addSubview(slikaPlava)
        self.view.addSubview(slikaBela)
        self.view.addSubview(labelAbout)
        self.view.addSubview(textView)
        self.view.addSubview(kopce)
        
        textView.text = about
        textView.isEditable = false
        kopce.layer.cornerRadius = 15
        kopce.clipsToBounds = true
    }
    
    @IBAction func kopceKlik(_ sender: Any) {
        
      if buttonHasBeenClicked {


  if let emailPacient = Auth.auth().currentUser?.email {
       
        
                Database.database().reference().child("Pacient").queryOrdered(byChild:
            "email").queryEqual(toValue: emailPacient).observe(.childAdded) { (snapshot) in
            if let patientDictionary = snapshot.value as? [String: AnyObject] {
             let PatientId = patientDictionary["id"] as? String
                let profilePic = patientDictionary["profileImageUrl"] as? String
                 let PatientFullName = patientDictionary["fullName"] as? String
                self.ref = Database.database().reference().child("Pregled")
                    
              
                
                
              
             
                
    
                

                
                
           
                
              
                
                self.ref.child(self.pomos.text!).removeValue()
                
          
                
                
                
            }
        }

        
        
       

       
      
     

                                     buttonHasBeenClicked = false

           kopce.setTitle("Изврши го ажурирањето", for: .normal)

                                 }
    
       }

                                 else {



 if let emailPacient = Auth.auth().currentUser?.email {
               
       Database.database().reference().child("Pacient").queryOrdered(byChild:
       "email").queryEqual(toValue: emailPacient).observe(.childAdded) { (snapshot) in
       if let patientDictionary = snapshot.value as? [String: AnyObject] {
        let PatientId = patientDictionary["id"] as? String
        let profilePic = patientDictionary["profileImageUrl"] as? String
        let PatientFullName = patientDictionary["fullName"] as? String
        self.ref = Database.database().reference().child("Pregled")
        
      
        
        let primarenKluc = self.ref.childByAutoId().key!
        self.pomos.text = primarenKluc
       
        print(self.pomos.text)
      //  self.ref?.child(primarenKluc!).updateChildValues(["id": primarenKluc, "DoctorId":self.id, "PatientId": PatientId, "date":"", "symptoms":"", "status": "", "examination": "", "diagnosis": "", "therapy":"", "profileImageUrl": profilePic])
        
        let dict = (["id":"\(primarenKluc)", "DoctorId":self.id, "PatientId": PatientId, "date":"", "symptoms":"", "status": "", "examination": "", "diagnosis": "", "therapy":"", "profileImageUrl": profilePic, "patientFullName": PatientFullName, "doctorFullName": self.name]) as [String : Any]
        
        
        self.ref?.child(primarenKluc).setValue(dict)
        
        self.buttonHasBeenClicked = true

        self.kopce.setTitle("Откажи",for: .normal)
        }
    }
       
       
             





        }
}

}
}
