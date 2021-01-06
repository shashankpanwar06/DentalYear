//
//  NotesViewController.swift
//  DentalYear
//
//  Created by Globizserve on 10/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var btnNotes: UIButton!
    @IBOutlet weak var btnGoals: UIButton!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewTopHeader: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblEmptyState: UILabel!
    @IBOutlet weak var viewEmptyState: UIView!
    var dataArray:[Notes] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configures()


    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    func configures() {
        self.view.layoutIfNeeded()
        btnNotes.makeButtonAllRoundCorner()
        btnGoals.makeButtonAllRoundCorner()
        viewTopHeader.makeRoundCorner()
        setupForNotes()
        configuretable()

    }
    
    func configuretable()  {
        tblList.register(UINib(nibName: "NoteCell", bundle: Bundle.main), forCellReuseIdentifier: "NoteCell")
        tblList.delegate = self
        tblList.dataSource = self
        tblList.reloadData()
    }
    
    func setupForNotes()
    {
            self.btnNotes.isSelected = true
            self.btnNotes.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
            self.btnGoals.isSelected = false
            self.btnGoals.backgroundColor = UIColor.clear
    }
    
    func setupForGoals()
    {
            self.btnNotes.isSelected = false
        
            self.btnNotes.backgroundColor = UIColor.clear
        
            self.btnGoals.isSelected = true
        
            self.btnGoals.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
    }
    

    func getData()  {
                
        if btnGoals.isSelected {
            dataArray = NoteAPI.sharedInstance.getGoals()
        }
        else
        {
            dataArray = NoteAPI.sharedInstance.getNotes()
            
        }
        if dataArray.count > 0 {
            emptyState(isShow: false)
        }else
        {
            emptyState(isShow: true)

        }
        tblList.reloadData()
    }
    @IBAction func onBtnGoals(_ sender: Any) {
        
        if btnGoals.isSelected {
            return
        }
        else
        {
            setupForGoals()
            getData()
        }

    }
    
    @IBAction func onBtnNotes(_ sender: Any) {
        
        if btnNotes.isSelected
        {
            return
        }else
        {
            setupForNotes()
            getData()

        }

    }
    @IBAction func onBtnAdd(_ sender: Any) {
        
        guard let addNoteVC:AddNotesViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as? AddNotesViewController else {return}
        
        if btnNotes.isSelected {
            addNoteVC.aType = .note
        }else
        {
            addNoteVC.aType = .goal
        }
        addNoteVC.aViewType = .new

        self.navigationController?.pushViewController(addNoteVC, animated: true)
    }
    func markNotePinned(aNote:Notes)  {
        
        NoteAPI.sharedInstance.updatePinnedStatus(aNote)
        getData()
        
    }
    
    func editNote(aNote:Notes)  {
        
        guard let addNoteVC:AddNotesViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as? AddNotesViewController else {return}
        addNoteVC.aViewType = .edit
        addNoteVC.aNote = aNote
        self.navigationController?.pushViewController(addNoteVC, animated: true)
        
    }
    
    func markDeleted(index:Int)  {
        
        NoteAPI.sharedInstance.updateDeletedStatus(dataArray[index])
        getData()
        
    }
    func tappedRow(index:Int)  {
        
//        NoteAPI.sharedInstance.updateDeletedStatus(dataArray[index])
//        getData()
        
        guard let notesDetailsVc:NotesDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotesDetailsViewController") as? NotesDetailsViewController else {return}
        
        notesDetailsVc.aNote = dataArray[index]

        self.navigationController?.pushViewController(notesDetailsVc, animated: true)
        
    }
    
    func emptyState(isShow:Bool)  {
        if isShow
        {
            tblList.isHidden = true
            viewEmptyState.isHidden = false
            if btnNotes.isSelected {
                lblEmptyState.text = "Your notes will appear here"
            }else
            {
                lblEmptyState.text = "Your goals will appear here"
            }
        }else
        {
            tblList.isHidden = false
            viewEmptyState.isHidden = true
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

}
