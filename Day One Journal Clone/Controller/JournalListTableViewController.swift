//
//  JournalListTableViewController.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import RealmSwift

class JournalListTableViewController: UITableViewController {
    let rowHeight : CGFloat = 100.0
    var savedJournals : Results<JournalEntry>?
    
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func initUI() {
        guard let navBar = navigationController?.navigationBar else { fatalError("Nav Bar missing")}
        navBar.barTintColor = UIColor.customBlue
        headerView.backgroundColor = UIColor.customBlue
        navBar.tintColor = .white
        navBar.isTranslucent = false
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
       // navigationController?.title = "Day One Clone"
        navBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        
    }
    
    
    func fetchData() {
        guard let realm = try? Realm() else {fatalError("Error with initializing Realm")}
        
         savedJournals = realm.objects(JournalEntry.self).sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
        
    }
    
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToAdd", sender: nil)
        
    }
    
    
    @IBAction func cameraAddPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToAdd", sender: "cameraButton")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(" prepare segue")
        if segue.identifier == "goToAdd" {
            if sender as? String == "cameraButton" {
                if let journalVC = segue.destination as? AddJournalViewController
                {
                    journalVC.cameraTappedFlag = true
                }
            }
        } else if segue.identifier == "tableToDetail" {
            print("segue identified")
            if let entry = sender as? JournalEntry {
                print("entry as journal entry")
                if let detailVC = segue.destination as? JournalDetailViewController {
                    print("success")
                    detailVC.selectedJournal = entry
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = savedJournals?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "journalPreviewCell", for: indexPath) as? JournalCell {
        
            if let record = savedJournals?[indexPath.row] {
                cell.previewTextView.text = record.text
                
                if let smalliImage =  record.pictures.first?.getsmallImage() {
                    cell.previewImageView.image = smalliImage
                    cell.constraintForImageViewWidth.constant = 100.0
                    
                } else {
                    cell.constraintForImageViewWidth.constant = 0.0
                    
                }
                
                cell.dayLabel.text = record.getDateComponent(component: "d")
                cell.monthLabel.text = record.getDateComponent(component: "MMM")
                cell.yearLabel.text = record.getDateComponent(component: "yyyy")
            }
        
        
        
        //code
        return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let entry = savedJournals?[indexPath.row] {
        performSegue(withIdentifier: "tableToDetail", sender: entry)
        } else {
            fatalError("selected table row is missing ")
        }
    }
    
    
    
}
