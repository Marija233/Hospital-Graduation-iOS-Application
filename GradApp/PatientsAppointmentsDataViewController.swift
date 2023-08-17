//
//  PatientsAppointmentsDataViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/13/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit

import FirebaseAuth

import FirebaseDatabase

class PatientsAppointmentsDataViewController: UIViewController {
    
    @IBOutlet weak var ocenkaTF: UITextField!
    
    @IBOutlet weak var kopceOcenka: UIButton!
    
    @IBOutlet weak var separator1: UIImageView!
    
      var ref: DatabaseReference!
    
    @IBOutlet weak var separator2: UIImageView!
    
    @IBOutlet weak var separator3: UIImageView!
    @IBOutlet weak var dijagnoza: UILabel!
    
    @IBOutlet weak var dijagnozaTV: UITextView!
    
    @IBOutlet weak var terapija: UILabel!
    
    @IBOutlet weak var terapijaTV: UITextView!
    
    @IBOutlet weak var simptomi: UILabel!
    
    @IBOutlet weak var datumraganjeTF: UITextField!
    
    @IBOutlet weak var simptomiTF: UITextField!
    
    @IBOutlet weak var pozadinska: UIImageView!
    
    @IBOutlet weak var labelDatumInsert: UILabel!
    @IBOutlet weak var slika: UIImageView!
    
    @IBOutlet weak var pzu: UILabel!
    
    @IBOutlet weak var pergledd: UILabel!
    @IBOutlet weak var kodLabel: UILabel!
    
    
    @IBOutlet weak var kopce: UIButton!
    @IBOutlet weak var kodinsertLabel: UILabel!
    
    @IBOutlet weak var datumRaganje: UILabel!
    
    
    @IBOutlet weak var imeprezimeLabel: UILabel!
    @IBOutlet weak var imeprezimeInsertLabel: UILabel!
    
    @IBOutlet weak var pregledalLabel: UILabel!
    
    @IBOutlet weak var pregledalInsertLabel: UILabel!
    
var buttonHasBeenClicked = false
    
    @IBOutlet weak var datumNaPregledLabel: UILabel!
    
    @IBOutlet weak var slika23: UIImageView!
    
    
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

        self.view.addSubview(pozadinska)
        self.view.addSubview(slika)
        self.view.addSubview(pzu)
        self.view.addSubview(pergledd)
        self.view.addSubview(kodLabel)
        self.view.addSubview(kodinsertLabel)
        self.view.addSubview(imeprezimeLabel)
        self.view.addSubview(imeprezimeInsertLabel)
        
        self.view.addSubview(datumRaganje)
        self.view.addSubview(datumraganjeTF)
        self.view.addSubview(datumNaPregledLabel)
        
        self.view.addSubview(slika23)
        
        slika.layer.borderWidth = 1.5
        slika.layer.borderColor = UIColor(red: 0.33, green: 0.58, blue: 0.89, alpha: 1.00).cgColor
        
        
        kodinsertLabel.text = PatientId
        imeprezimeInsertLabel.text = patientFullName
        pregledalInsertLabel.text = doctorFullName
        labelDatumInsert.text = date
        dijagnozaTV.text = diagnosis
        terapijaTV.text = therapy
            kopce.layer.cornerRadius = 15
            kopce.clipsToBounds = true
        
    
          let slikaUrl = URL(string: profileImageUrl)
              let slikaData = try! Data(contentsOf: slikaUrl!)
              slika23.image = UIImage(data: slikaData)
        
        if diagnosis == "" && therapy == ""
        {
            kopceOcenka.isHidden = true
            ocenkaTF.isHidden = true
        }
        else
        {
            kopceOcenka.isHidden = false
            ocenkaTF.isHidden = false
            
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
  
         
    
         */
    
  
    @IBAction func kopceOcenka(_ sender: Any) {
        
        
         Database.database().reference().child("DoktorSpecijalist").queryOrdered(byChild: "id").queryEqual(toValue: DoctorId).observe(.childAdded) { (snapshot) in
                           let dict = snapshot.value as! [String: AnyObject]
                           
                          
                          
                          let NoOfRaters = dict["NoOfRaters"] as? String ?? ""
                   let sum = dict["sum"] as? String ?? ""
                           self.ocenkaTF.isHidden = false
                           self.kopceOcenka.isHidden = false
                         
            self.ref = Database.database().reference().child("DoktorSpecijalist").child(self.DoctorId)


                   var IntNoOfRaters = Int(NoOfRaters)
                   var IntSum = Int(sum)
                  
                   let pom = Int(self.ocenkaTF.text!)
                   IntNoOfRaters = IntNoOfRaters! + 1
                     self.ref?.updateChildValues(["NoOfRaters": String(IntNoOfRaters!)])
                     IntSum = IntSum! + pom!
                     self.ref?.updateChildValues(["sum": String(IntSum!) ])
                 
                  
                 // rejting = (sum!)/(raters!)
                  
                   
                   
                  
                   
                       }
                 
           
        
        
    }

    
    
    @IBAction func kopceKlik(_ sender: Any) {
        
        
        if buttonHasBeenClicked {



        ref = Database.database().reference().child("PregledPotvrden").child(id)
    //    ref?.updateChildValues(["id":id, "email": email, "fullName": name, "role": role, "specialty":"", "sum": sum, "NoOfRaters": NoOfRaters, "about":about, "profileImageUrl": profileImageUrl])
            ref?.updateChildValues(["id":id, "DoctorId":DoctorId, "PatientId": PatientId, "date":date, "symptoms":"", "status": status, "examination": "", "diagnosis": diagnosis, "therapy":therapy, "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])
            
        
        
       // ref?.removeValue()

                                      buttonHasBeenClicked = false

            kopce.setTitle("Изврши го ажурирањето", for: .normal)

                                  }

                                  else {





                  ref = Database.database().reference().child("PregledPotvrden").child(id)

    //    ref?.updateChildValues(["id":id ,"email": email, "fullName": name, "role": role, "specialty": specialtyTF.text, "sum": sum, "NoOfRaters": NoOfRaters, "about": aboutTF.text, "profileImageUrl":profileImageUrl])
        
          ref?.updateChildValues(["id":id, "DoctorId":DoctorId, "PatientId": PatientId, "date":date, "symptoms":simptomiTF.text, "status": status, "examination": datumraganjeTF.text, "diagnosis": diagnosis, "therapy":therapy, "profileImageUrl": profileImageUrl, "patientFullName": patientFullName, "doctorFullName": doctorFullName])
                  
        
                                      buttonHasBeenClicked = true

            kopce.setTitle("Откажи",for: .normal)






    }
}
    
  
}
