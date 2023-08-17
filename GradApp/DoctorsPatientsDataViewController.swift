//
//  DoctorsPatientsDataViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/13/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit

import FirebaseAuth

import FirebaseDatabase

class DoctorsPatientsDataViewController: UIViewController {
    @IBOutlet weak var slika24: UIImageView!
    
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var naslov: UILabel!
    
    @IBOutlet weak var pozadina: UIImageView!
    
      var ref: DatabaseReference!
    
    @IBOutlet weak var pregled: UILabel!
    
    @IBOutlet weak var kodPacient: UILabel!
    @IBOutlet weak var kodPacientLabel: UILabel!
    
    @IBOutlet weak var imePrezime: UILabel!
    @IBOutlet weak var imePrezimeLabel: UILabel!
    @IBOutlet weak var datumRaganje: UILabel!
    @IBOutlet weak var datumRaganjeLabel: UILabel!
    
    @IBOutlet weak var datumPregled: UILabel!
    
    @IBOutlet weak var datumPregledLabel: UITextField!
    
    @IBOutlet weak var pregledal: UILabel!
    
    @IBOutlet weak var pregledalLabel: UILabel!
    
    @IBOutlet weak var separator1: UIImageView!
    
    @IBOutlet weak var simptomi: UILabel!
    
    @IBOutlet weak var simptomiTV: UITextView!
    
    @IBOutlet weak var separator2: UIImageView!
    
    @IBOutlet weak var dijagnoza: UILabel!
    
    @IBOutlet weak var dijagnozaTF: UITextField!
    
    @IBOutlet weak var separator3: UIImageView!
    
    @IBOutlet weak var terapija: UILabel!
    
    @IBOutlet weak var terapijTF: UITextField!
    
        
    var buttonHasBeenClicked = false
    @IBOutlet weak var kopce: UIButton!
    
    
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

        self.view.addSubview(pozadina)
      self.view.addSubview(logo)
        self.view.addSubview(naslov)
        self.view.addSubview(pregled)
        self.view.addSubview(kodPacient)
        self.view.addSubview(kodPacientLabel)
        self.view.addSubview(imePrezime)
        self.view.addSubview(imePrezimeLabel)
        self.view.addSubview(datumRaganje)
        self.view.addSubview(datumRaganjeLabel)
        self.view.addSubview(datumPregled)
        self.view.addSubview(datumPregledLabel)
        self.view.addSubview(pregledal)
        self.view.addSubview(pregledalLabel)
        self.view.addSubview(slika24)
        kodPacientLabel.text = PatientId
        imePrezimeLabel.text = patientFullName
        datumRaganjeLabel.text = examination
        pregledalLabel.text = "Dr. " + doctorFullName
        simptomiTV.text = symptoms
        
        simptomiTV.isEditable = false
        
         logo.layer.borderWidth = 1.5
               logo.layer.borderColor = UIColor(red: 0.33, green: 0.58, blue: 0.89, alpha: 1.00).cgColor
        
        kopce.layer.cornerRadius = 15
                kopce.clipsToBounds = true
            
        
              let slikaUrl = URL(string: profileImageUrl)
                  let slikaData = try! Data(contentsOf: slikaUrl!)
                  slika24.image = UIImage(data: slikaData)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func kopceKlik(_ sender: Any) {
         if buttonHasBeenClicked {



               ref = Database.database().reference().child("PregledPotvrden").child(id)
           //    ref?.updateChildValues(["id":id, "email": email, "fullName": name, "role": role, "specialty":"", "sum": sum, "NoOfRaters": NoOfRaters, "about":about, "profileImageUrl": profileImageUrl])
                   ref?.updateChildValues(["id":id, "DoctorId":DoctorId, "PatientId": PatientId, "date":"", "symptoms":symptoms, "status": status, "examination": examination, "diagnosis": "", "therapy":"", "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])
                   
               
               
              // ref?.removeValue()

                                             buttonHasBeenClicked = false

                   kopce.setTitle("Изврши го ажурирањето", for: .normal)

                                         }

                                         else {





                         ref = Database.database().reference().child("PregledPotvrden").child(id)

           //    ref?.updateChildValues(["id":id ,"email": email, "fullName": name, "role": role, "specialty": specialtyTF.text, "sum": sum, "NoOfRaters": NoOfRaters, "about": aboutTF.text, "profileImageUrl":profileImageUrl])
               
            ref?.updateChildValues(["id":id, "DoctorId":DoctorId, "PatientId": PatientId, "date":datumPregledLabel.text, "symptoms":symptoms, "status": status, "examination": examination, "diagnosis": dijagnozaTF.text, "therapy":terapijTF.text, "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])
                         
               
                                             buttonHasBeenClicked = true

                   kopce.setTitle("Откажи",for: .normal)


    }
    
}
}
