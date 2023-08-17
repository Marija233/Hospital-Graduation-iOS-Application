//
//  AppointmentsDataViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/13/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit

import FirebaseAuth


import FirebaseDatabase

class AppointmentsDataViewController: UIViewController {

    
    @IBOutlet weak var slika: UIImageView!
    
    
    @IBOutlet weak var labelImePrezime: UILabel!
    
         var ref: DatabaseReference!

    @IBOutlet weak var belaSlika: UIImageView!
    @IBOutlet weak var plavaSlika: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var kopce: UIButton!
        var buttonHasBeenClicked = false
    
       var DoctorId = ""
        var PatientId = ""
                  var  date = ""
               var diagnosis = ""
           var doctorFullName = ""
                                
                var examination = ""
                                    
                        var id = ""
              var  patientFullName = ""
         var   profileImageUrl = ""
              var  status = ""
              var  symptoms = ""
                 var   therapy = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.view.addSubview(plavaSlika)
               self.view.addSubview(labelImePrezime)
               self.view.addSubview(belaSlika)
        self.view.addSubview(textField)
        
               self.view.addSubview(kopce)
        
        
         kopce.layer.cornerRadius = 15
                kopce.clipsToBounds = true
            
       
        labelImePrezime.text =  patientFullName
        
        
                

               // za koga ke raboti storage:
                 let slikaUrl = URL(string: profileImageUrl)
                let slikaData = try! Data(contentsOf: slikaUrl!)
                slika.image = UIImage(data: slikaData)    }
    

    @IBAction func kopceAkcija(_ sender: Any) {
        
         if buttonHasBeenClicked {



           ref = Database.database().reference().child("Pregled").child(id)
           ref?.updateChildValues(["id":id, "DoctorId": DoctorId, "PatientId": PatientId, "date": date, "symptoms": symptoms, "status": status, "examination": examination, "diagnosis": diagnosis, "therapy": therapy, "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])

           
           ref = Database.database().reference().child("PregledPotvrden").child(id)
           ref?.removeValue()

                                         buttonHasBeenClicked = false

               kopce.setTitle("Закажи преглед", for: .normal)

                                     }

                                     else {





                     ref = Database.database().reference().child("Pregled").child(id)

            ref?.updateChildValues(["id":id, "DoctorId": DoctorId, "PatientId": PatientId, "date": date, "symptoms": symptoms, "status": textField.text, "examination": examination, "diagnosis": diagnosis, "therapy": therapy, "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])
           
           
                    ref = Database.database().reference().child("PregledPotvrden").child(id)
           
            ref?.updateChildValues(["id":id, "DoctorId": DoctorId, "PatientId": PatientId, "date": date, "symptoms": symptoms, "status": textField.text, "examination": examination, "diagnosis": diagnosis, "therapy": therapy, "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])
           
           
                                         buttonHasBeenClicked = true

               kopce.setTitle("Откажи",for: .normal)






        
        
        
    }
    
}
}
