//
//  AddJournalViewController.swift
//  Day One Journal Clone
//
//  Created by Vigneshraj Sekar Babu on 6/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import RealmSwift
import Spring

class AddJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //let customBlue = UIColor(red: 113/255, green: 211/255, blue: 255/255, alpha: 1)
    let setBottomConstraint : CGFloat = 0.0
    let sizeOfImagesInScrollView : CGFloat = 60.0
    
    @IBOutlet weak var bottomScrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewJournal: UITextView!
    @IBOutlet weak var datePickerForJournal: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    
    @IBOutlet weak var topViewForBackground: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewInsideScrollVIew: UIStackView!
    
    //var date = Date()
    var journalEntry = JournalEntry()
    var imagePicker = UIImagePickerController()
    var images : [UIImage] = []
    var cameraTappedFlag : Bool = false
    
    
    fileprivate func initUI() {
        datePickerForJournal.isHidden = true
        setDateButton.isHidden = true
        navBar.barTintColor = UIColor.customBlue
        navBar.isTranslucent = true
        navBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navBar.tintColor = UIColor.white
        topViewForBackground.backgroundColor = UIColor.customBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFormattedDateasTitle(date: journalEntry.date)
        if cameraTappedFlag {
            cameraTappedFlag = !cameraTappedFlag
            cameraTapped("")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        if cameraTappedFlag {
        //            cameraTappedFlag = !cameraTappedFlag
        //            cameraTapped("")
        //        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        updateBottonConstraintForKeyboardHeight(notification: notification)
    }
    
    @objc func keyboardWillHide(notification : Notification) {
        bottomScrollViewConstraint.constant = 0.0
        //  updateBottonConstraintForKeyboardHeight(notification: notification)
    }
    
    func updateBottonConstraintForKeyboardHeight(notification : Notification) {
        print(" before : \(bottomScrollViewConstraint.constant) ")
        if let keyboardFrame  = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as?  NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            bottomScrollViewConstraint.constant = keyboardHeight + setBottomConstraint - (keyboardHeight/10)
            print("keyboard height : \(keyboardFrame.cgRectValue.height)")
            print(" after : \(bottomScrollViewConstraint.constant) ")
            
        }
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
            //nothing
        }
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        do {
            let realm = try Realm()
            try realm.write {
                let entry = JournalEntry()
                entry.text = textViewJournal.text
                entry.date = journalEntry.date
                for image in images {
                    let picture = Pictures(image: image)
                    entry.pictures.append(picture)
                    picture.entry = entry
                }
                realm.add(entry)
                
            }
            
        } catch {
            fatalError("cannot with Realm object : \(error)")
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func setDatePressed(_ sender: UIButton) {
        journalEntry.date = datePickerForJournal.date
        setFormattedDateasTitle(date: journalEntry.date)
        self.textViewJournal.isHidden = false
        self.setDateButton.isHidden = true
        self.datePickerForJournal.isHidden = true
        
    }
    
    func setFormattedDateasTitle(date : Date) {
        navBar.topItem?.title =  journalEntry.getFormattedDate(date: journalEntry.date)
    }
    
    @IBAction func calendarTapped(_ sender: UIButton) {
        datePickerForJournal.date = journalEntry.date
        UIView.animate(withDuration: 5) {
            self.textViewJournal.isHidden = true
            self.setDateButton.isHidden = false
            self.datePickerForJournal.isHidden = false
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.images.append(selectedImage)
            let imageView = SpringImageView()
            imageView.image = selectedImage
            imageView.heightAnchor.constraint(equalToConstant: sizeOfImagesInScrollView).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: sizeOfImagesInScrollView).isActive = true
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            self.stackViewInsideScrollVIew.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true) {
                imageView.animation = "squeezeLeft"
                imageView.animate()
                
            }
        }
       
    }
    
}


