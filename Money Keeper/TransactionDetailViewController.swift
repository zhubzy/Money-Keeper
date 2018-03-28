//
//  TransactionDetailViewController.swift
//  
//
//  Created by Zach Zhong on 31/07/2017.
//
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var receiptImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    var transaction = Transaction()
    var summaryVC: SummaryViewController? = nil
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let receiptImage = transaction.receiptImage {
            receiptImageView.image = receiptImage
        }
        
        if let actualNote = transaction.note {
            
            notesLabel.text = actualNote
            titleLabel.title = actualNote
            
        }
        
        
        
        amountLabel.text = transaction.amountToDisplay!
        dateLabel.text = transaction.dateToDisplay!
        categoryLabel.text = transaction.currentCategory!
        titleLabel.title = "Transaction Detail"
        

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        let destinationVC = segue.destination as! EditViewController
        
        destinationVC.loadViewIfNeeded()
        
        
        if transaction.isExpense == false {
            
            destinationVC.currentStateIsExpense = false

        }

        
        if let receiptImage = transaction.receiptImage {
            destinationVC.receiptPhotoView.image = receiptImage
            destinationVC.receiptView.isHidden = false
        }
        
        if let actualNote = transaction.note {
            
            destinationVC.title = actualNote
            destinationVC.notes.text = actualNote
            
        } else {
            
            destinationVC.title = transaction.currentCategory!

            
        }
        
        
        
        destinationVC.amountTextField.text = transaction.amountToDisplay!
        destinationVC.amountInDouble = transaction.amount
        destinationVC.dateTextField.text = transaction.dateToDisplay!
        destinationVC.categoryTextField.text = transaction.currentCategory!
        destinationVC.destinationVC = self

        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        
        
        if let actualIndex = selectedIndex {
            
            summaryVC?.transactions[actualIndex] = transaction
            
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
  
    @IBAction func editTransaction(_ sender: Any) {
        
        
        
        
    }
    
}
