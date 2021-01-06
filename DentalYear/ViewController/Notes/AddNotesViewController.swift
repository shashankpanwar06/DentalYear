//
//  AddNotesViewController.swift
//  DentalYear
//
//  Created by Globizserve on 10/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import EzPopup
import DatePickerDialog
enum type {
    case note
    case goal
}
enum viewType {
    case new
    case edit
}
class AddNotesViewController: UIViewController {

    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var viewTitleInner: UIView!
    @IBOutlet weak var viewHeaderInner: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    
    var selectedDate:Date = Date()
    
    var aType:type?
    var aViewType:viewType?
    var aNote:Notes?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,YYYY"
        selectedDate  = Date()
        self.btnDate.setTitle(dateFormatter.string(from: Date()), for: .normal)
//        addtapGentureToDatelable()
        if aViewType == .edit {
            guard let aNotes = self.aNote else {
                return
            }
            configureForEdit(thisNote: aNotes)

        }



        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureView()

    }
    
    func configureForEdit(thisNote:Notes)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,YYYY"
        selectedDate  = thisNote.date
        self.btnDate.setTitle(dateFormatter.string(from: thisNote.date), for: .normal)
        txtTitle.text = thisNote.title
        txtDetails.text = thisNote.details
    }

    @IBAction func onBtnDate(_ sender: Any) {
        DatePickerDialog.init(textColor: .black, buttonColor: HomeStaticdata.getForgroundColorFor(index: 3), font: UIFont(name: "MontserratRegular", size: 12) ?? UIFont.systemFont(ofSize: 12), locale: nil, showCancelButton: true).show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: Date(), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd,YYYY"
                self.selectedDate  = dt
                self.btnDate.setTitle(dateFormatter.string(from: dt), for: .normal)
            }
        }
    }
    
    func addtapGentureToDatelable()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        lblDate.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    func configureView()  {
        
        viewHeaderInner.makeRoundCorner()
        viewTitleInner.makeRoundCorner()
        viewDetails.makeRoundCorner()
        
        
    }
    @IBAction func onBtnBack(_ sender: Any) {
        
        if txtTitle.text != "" || txtDetails.text != ""
        {
            let customPopUp:CustomPopUp = CustomPopUp.init(nibName: "CustomPopUp", bundle: Bundle.main)
            let popupVC = PopupViewController(contentController: customPopUp, popupWidth: self.view.frame.width - 30, popupHeight: 250)
            customPopUp.set(title: "Unsave Changes", description: "If you exit now all unsaved changes will be discarded", affermativeText: "Exit", cancelText: "Cancel", showCancel: true, showaffermative: true, selfHide: false)
                       
            customPopUp.affirmativeBtnBtnPressed = {
                popupVC.dismiss(animated: true) {
                }
                self.navigationController?.popViewController(animated: true)
            }
                       
            customPopUp.cancelBtnBtnPressed = {
                popupVC.dismiss(animated: true) {
                    
                }
            }
            self.present(popupVC, animated: true) {
            }
        }
        else
        {
            self.navigationController?.popViewController(animated: true)

        }
    }
    @IBAction func onBtnSave(_ sender: Any) {
        
        if txtTitle.text == "" {
            let customPopUp:CustomPopUp = CustomPopUp.init(nibName: "CustomPopUp", bundle: Bundle.main)
            let popupVC = PopupViewController(contentController: customPopUp, popupWidth: self.view.frame.width - 30, popupHeight: 150)
            customPopUp.set(title: "Missing title", description: "Please input some title", affermativeText: "Exit", cancelText: "Cancel", showCancel: false, showaffermative: false, selfHide: true)
                       
            customPopUp.affirmativeBtnBtnPressed = {
                popupVC.dismiss(animated: true) {
                }
                self.navigationController?.popViewController(animated: true)
            }
                       
            customPopUp.cancelBtnBtnPressed = {
                popupVC.dismiss(animated: true) {
                    
                }
            }
            self.present(popupVC, animated: true) {
            }
        }
        
        if aViewType == .edit
        {
            updateNote()
        }else
        {
            saveNote()
        }
    
    }
    func saveNote()  {
        
        var type:Int = 0
        if aType == .goal
        {
            type = 1
        }
        NoteAPI.sharedInstance.saveEvent(noteTitle: txtTitle.text!, noteDetails: txtDetails.text!, type: type, aDate: selectedDate)
        self.navigationController?.popViewController(animated: true)

    }
    
    func updateNote()  {
        
        guard let aNotes = self.aNote else {
            return
        }
        NoteAPI.sharedInstance.updateNote(noteTitle: txtTitle.text!, noteDetails: txtDetails.text, aDate:selectedDate, aNote: aNotes)
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
