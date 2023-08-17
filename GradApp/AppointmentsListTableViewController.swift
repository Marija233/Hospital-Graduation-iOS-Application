//
//  AppointmentsListTableViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 10/12/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AppointmentsListTableViewController: UITableViewController {

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
             
             
              let  status = ""
             
             
             Database.database().reference().child("Pregled").queryOrdered(byChild:
                 "status").queryEqual(toValue: status).observe(.childAdded) { (snapshot) in
                 if let appointmentDictionary = snapshot.value as? [String: AnyObject] {
                     self.appointmentRequests.append(appointmentDictionary)
                     self.tableView.reloadData()
                 }
             }
             Database.database().reference().child("Pregled").observe(.childRemoved) { (snapshot) in
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
             Database.database().reference().child("Pregled").observe(.childChanged) { (snapshot) in
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
             }
             
             
         }
    

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
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsCell", for: indexPath)
        //bese docreq[indexpath.row]
            let appointmentDictionary = appointmentRequests[indexPath.section]
     if let patientFullName = appointmentDictionary["patientFullName"] as? String {
         
          let profileImageUrl = appointmentDictionary["profileImageUrl"] as? String















                              var url = URL(string: profileImageUrl!)

                                  URLSession.shared.dataTask(with: url!,
                  completionHandler: { (data, response, error) in



                                      if error != nil

                                      {

                                          print(error)

                                          return

                                      }

                                      DispatchQueue.main.async() {

                                          cell.imageView?.image = UIImage(data: data!)

                                          tableView.reloadData()

                                      }







                                      }).resume()





                              cell.textLabel?.text = patientFullName



        
    }
        return cell
    }
    
    
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let appointmentRequest = appointmentRequests[indexPath.section]
       
            performSegue(withIdentifier: "anotherSegue", sender: appointmentRequest)
        }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let acceptVC3 = segue.destination as? AppointmentsDataViewController  {
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
                           acceptVC3.DoctorId = DoctorId
                                 acceptVC3.PatientId = PatientId
                       acceptVC3.date  = date
                                 acceptVC3.diagnosis = diagnosis
                           acceptVC3.doctorFullName = doctorFullName
                               
                               acceptVC3.examination = examination
                                   
                                   acceptVC3.id = id
                                       acceptVC3.patientFullName = patientFullName
                                           acceptVC3.profileImageUrl = profileImageUrl
                                                    acceptVC3.status = status
                                                    acceptVC3.symptoms = symptoms
                                                    acceptVC3.therapy = therapy
                                                    
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

