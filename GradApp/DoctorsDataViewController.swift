//
//  DoctorsDataViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/4/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit

import FirebaseAuth


import FirebaseDatabase



class DoctorsDataViewController: UIViewController {




    @IBOutlet weak var text: UILabel!

    @IBOutlet weak var specialtyTF: UITextField!


   
    @IBOutlet weak var kopce: UIButton!


    @IBOutlet weak var slika: UIImageView!
    
        var ref: DatabaseReference!

    
    @IBOutlet weak var belaslika1: UIImageView!
    
    @IBOutlet weak var belaslika2: UIImageView!
    
    @IBOutlet weak var belaslika3: UIImageView!
    
    @IBOutlet weak var belaslika4: UIImageView!
    @IBOutlet weak var belaslika5: UIImageView!
    
    @IBOutlet weak var slika3: UIImageView!
    
    @IBOutlet weak var aboutTF: UITextField!
    @IBOutlet weak var slika2: UIImageView!
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
        self.view.addSubview(slika)
        self.view.addSubview(slika2)
        self.view.addSubview(slika3)
        self.view.addSubview(kopce)
        self.view.addSubview(specialtyTF)
        self.view.addSubview(text)
        
        self.view.addSubview(belaslika1)
       self.view.addSubview(belaslika2)
         self.view.addSubview(belaslika3)
         self.view.addSubview(belaslika4)
         self.view.addSubview(belaslika5)
        self.view.addSubview(aboutTF)
        
        kopce.layer.cornerRadius = 15
        kopce.clipsToBounds = true
        text.text = name
print(profileImageUrl)


print(name)

        
        
        

       // za koga ke raboti storage:
         let slikaUrl = URL(string: profileImageUrl)
        let slikaData = try! Data(contentsOf: slikaUrl!)
        slika.image = UIImage(data: slikaData)



    }



    @IBAction func buttonTapped(_ sender: Any) {



  if buttonHasBeenClicked {



    ref = Database.database().reference().child("Doktor").child(id)
    ref?.updateChildValues(["id":id, "email": email, "fullName": name, "role": role, "specialty":"", "sum": sum, "NoOfRaters": NoOfRaters, "about":about, "profileImageUrl": profileImageUrl])

    
    ref = Database.database().reference().child("DoktorSpecijalist").child(id)
    ref?.removeValue()

                                  buttonHasBeenClicked = false

        kopce.setTitle("Изврши го ажурирањето", for: .normal)

                              }

                              else {





              ref = Database.database().reference().child("Doktor").child(id)

    ref?.updateChildValues(["id":id ,"email": email, "fullName": name, "role": role, "specialty": specialtyTF.text, "sum": sum,
                                                    "NoOfRaters": NoOfRaters, "about": aboutTF.text, "profileImageUrl":profileImageUrl])
    
    
             ref = Database.database().reference().child("DoktorSpecijalist").child(id)
    
    ref?.updateChildValues(["id":id, "email": email, "fullName": name, "role": role, "specialty": specialtyTF.text, "sum": sum,
                                                      "NoOfRaters": NoOfRaters, "about": aboutTF.text, "profileImageUrl":profileImageUrl])
    
    
                                  buttonHasBeenClicked = true

        kopce.setTitle("Откажи",for: .normal)











        }

    }





}
