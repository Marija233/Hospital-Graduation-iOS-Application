//
//  DoctorsListTableViewController.swift
//  GradApp
//
//  Created by Marija Cholakova on 9/28/22.
//  Copyright © 2022 Marija Cholakova. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DoctorsListTableViewController: UITableViewController {

      var doctorRequests = [Dictionary<String, AnyObject>()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
     tableView.subviews.forEach { view in
        
       
       /* view.layer.shadowColor = UIColor.lightGray.cgColor
         view.layer.shadowOpacity = 0.4
         view.layer.shadowOffset = .zero
         view.layer.shadowRadius = 3*/
        
        view.layer.cornerRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor
        
     }
        
        
        doctorRequests.remove(at: 0)
        
        
         let  doctorSpecialty = ""
        
        
        Database.database().reference().child("Doktor").queryOrdered(byChild:
            "specialty").queryEqual(toValue: doctorSpecialty).observe(.childAdded) { (snapshot) in
            if let doctorDictionary = snapshot.value as? [String: AnyObject] {
                self.doctorRequests.append(doctorDictionary)
                self.tableView.reloadData()
            }
        }
        Database.database().reference().child("Doktor").observe(.childRemoved) { (snapshot) in
            if let doctorDictionary = snapshot.value as? [String: AnyObject] {
                if let email = doctorDictionary["email"] as? String {
                    for index in 0..<self.doctorRequests.count {
                        if let emailreq = self.doctorRequests[index]["email"] as? String {
                            if emailreq == email {
                                self.doctorRequests.remove(at: index)
                                self.tableView.reloadData()
                                break;
                            }
                        }
                    }
                }
            }
        }
        Database.database().reference().child("Doktor").observe(.childChanged) { (snapshot) in
            if let doctorDictionary = snapshot.value as? [String: AnyObject] {
                if let email = doctorDictionary["email"] as? String {
                    for index in 0..<self.doctorRequests.count {
                        if let emailreq = self.doctorRequests[index]["email"] as? String {
                            if emailreq == email {
                                self.doctorRequests[index] = doctorDictionary
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
        return doctorRequests.count //swap so dolna fja - tuka bese 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1 //swap so gorna fja - tuka bese doctorrequests.count
        
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorsCell", for: indexPath)
//bese docreq[indexpath.row]
    let doctorDictionary = doctorRequests[indexPath.section]
          if let email = doctorDictionary["email"] as? String {
               let fullName = doctorDictionary["fullName"] as? String
                let specialty = doctorDictionary["specialty"] as? String
            

                
          //  cell.textLabel?.text = "Dr. " + fullName!
          
            let profileImageUrl = doctorDictionary["profileImageUrl"] as? String















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





                        cell.textLabel?.text = "Dr. " + fullName!



                              


            
        }
              
          
        return cell
    }
    
  /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     //bese .row lets see
        let doctorRequest = doctorRequests[indexPath.section]
        performSegue(withIdentifier: "infoSegue", sender: doctorRequest)
        
        return true
    }
    */
    
   
  /*  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //bese .row lets see
        if  let vc = storyboard?.instantiateViewController(identifier: "DoctorsDataViewController") as? DoctorsDataViewController
        {
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }*/
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let doctorRequest = doctorRequests[indexPath.section]
      
           performSegue(withIdentifier: "infoSegue", sender: doctorRequest)
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
    @IBAction func logoutTapped(_ sender: Any) {
        
         try? Auth.auth().signOut()
                navigationController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func clickButton(_ sender: Any) {
        self.performSegue(withIdentifier: "clickSegue", sender: nil)
    }
    
    
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
    if let acceptVC = segue.destination as? DoctorsDataViewController  {
        if let doctorRequest = sender as? Dictionary<String, AnyObject> {
            if let email = doctorRequest["email"] as? String {
          
          if let name = doctorRequest["fullName"] as? String{
           
            if let specialty = doctorRequest["specialty"] as? String {
                 
                  if let id = doctorRequest["id"] as? String {
                 
                    if let role = doctorRequest["role"] as? String {
                        
                        if let sum = doctorRequest["sum"] as? String {
                     
                            if let NoOfRaters = doctorRequest["NoOfRaters"] as? String {
                                if let about = doctorRequest["about"] as? String {
                            
                                    if let profileImageUrl = doctorRequest["profileImageUrl"] as? String {
                        acceptVC.email = email
                              acceptVC.name = name
                    acceptVC.specialty  = specialty
                              acceptVC.id = id
                        acceptVC.role = role
                            
                            acceptVC.sum = sum
                                
                                acceptVC.NoOfRaters = NoOfRaters
                                    acceptVC.about = about
                                        acceptVC.profileImageUrl = profileImageUrl
                                        
                                        
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


