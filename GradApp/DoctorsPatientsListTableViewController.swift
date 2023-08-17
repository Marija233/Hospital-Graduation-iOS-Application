//
//  DoctorsPatientsListTableViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/13/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DoctorsPatientsListTableViewController: UITableViewController {
    
 var appointmentRequests = [Dictionary<String, AnyObject>()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

           tableView.subviews.forEach { view in
                       
              
                       view.layer.cornerRadius = 8
                       view.layer.shadowOffset = CGSize(width: 0, height: 3)
                       view.layer.shadowRadius = 3
                       view.layer.shadowOpacity = 0.3
                       view.layer.shadowColor = UIColor.black.cgColor
                       
                    }
                       
                       
                       appointmentRequests.remove(at: 0)
                       
                       
                        let  status = "potvrdi"
                       
                       
                       Database.database().reference().child("PregledPotvrden").queryOrdered(byChild:
                           "status").queryEqual(toValue: status).observe(.childAdded) { (snapshot) in
                           if let appointmentDictionary = snapshot.value as? [String: AnyObject] {
                               self.appointmentRequests.append(appointmentDictionary)
                               self.tableView.reloadData()
                           }
                       }
                       Database.database().reference().child("PregledPotvrden").observe(.childRemoved) { (snapshot) in
                           if let appointmentDictionary = snapshot.value as? [String: AnyObject] {
                               if let id = appointmentDictionary["id"] as? String {
                                   for index in 0..<self.appointmentRequests.count {
                                       if let idreq = self.appointmentRequests[index]["id"] as? String {
                                           if idreq == id {
                                               self.appointmentRequests.remove(at: index)
                                               self.tableView.reloadData()
                                               break;
                                           }
                                       }
                                   }
                               }
                           }
                       }
                       Database.database().reference().child("PregledPotvrden").observe(.childChanged) { (snapshot) in
                           if let appointmentDictionary = snapshot.value as? [String: AnyObject] {
                               if let id = appointmentDictionary["id"] as? String {
                                   for index in 0..<self.appointmentRequests.count {
                                       if let idreq = self.appointmentRequests[index]["id"] as? String {
                                           if idreq == id {
                                               self.appointmentRequests[index] = appointmentDictionary
                                               self.tableView.reloadData()
                                           }
                                       }
                                   }
                               }
                           }
                       }    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return appointmentRequests.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "appointments3Cell", for: indexPath)

      let appointmentDictionary = appointmentRequests[indexPath.section]
       if let patientFullName = appointmentDictionary["patientFullName"] as? String {
           
          //  let profileImageUrl = appointmentDictionary["profileImageUrl"] as? String















                         //       var url = URL(string: profileImageUrl!)

                    //                URLSession.shared.dataTask(with: url!,
                    //completionHandler: { (data, response, error) in



                                  //      if error != nil

                                    //    {

                                      //      print(error)

                                        //    return

                                        //}

                                        //DispatchQueue.main.async() {

                                          //  cell.imageView?.image = UIImage(data: data!)

                                        //    tableView.reloadData()

                                        //}







                                       // }).resume()





                                cell.textLabel?.text =  "Pacient " + patientFullName



          
      }
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let appointmentRequest = appointmentRequests[indexPath.section]
        
             performSegue(withIdentifier: "lalaSegue", sender: appointmentRequest)
         }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    @IBAction func logout(_ sender: Any) {
        
        try? Auth.auth().signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let acceptVC5 = segue.destination as? DoctorsPatientsDataViewController {
          if let appointmentRequest = sender as? Dictionary<String, AnyObject> {
              if let DoctorId = appointmentRequest["DoctorId"] as? String {
            
            if let PatientId = appointmentRequest["PatientId"] as? String{
             
              if let date = appointmentRequest["date"] as? String {
                   
                    if let diagnosis = appointmentRequest["diagnosis"] as? String {
                   
                      if let doctorFullName = appointmentRequest["doctorFullName"] as? String {
                          
                          if let examination = appointmentRequest["examination"] as? String {
                       
                              if let id = appointmentRequest["id"] as? String {
                                  if let patientFullName = appointmentRequest["patientFullName"] as? String {
                              
                                      if let profileImageUrl = appointmentRequest["profileImageUrl"] as? String {
                                       
                                       if let status = appointmentRequest["status"] as? String {
                                           
                                           if let symptoms = appointmentRequest["symptoms"] as? String {
                                               
                                               if let therapy = appointmentRequest["therapy"] as? String {
                          acceptVC5.DoctorId = DoctorId
                                acceptVC5.PatientId = PatientId
                      acceptVC5.date  = date
                                acceptVC5.diagnosis = diagnosis
                          acceptVC5.doctorFullName = doctorFullName
                              
                              acceptVC5.examination = examination
                                  
                                  acceptVC5.id = id
                                      acceptVC5.patientFullName = patientFullName
                                          acceptVC5.profileImageUrl = profileImageUrl
                                                   acceptVC5.status = status
                                                   acceptVC5.symptoms = symptoms
                                                   acceptVC5.therapy = therapy
                                                   
                                               }
                                          
                                      }
                                       }
                                   }
                                      
                                  
                                  }
                              
                              }
                              
                          }
                                
                      }
                  }
                          
                  
                  }
                          
                        
                
                    }
                }
                
                }
            }
      }

}
