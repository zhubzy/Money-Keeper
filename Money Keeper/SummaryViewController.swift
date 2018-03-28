//
//  SummaryViewController.swift
//  Money Keeper
//
//  Created by Zach Zhong on 7/3/17.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit
import CoreData

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var transactions = [Transaction]()
    var transactionsByAmountAscending = [Transaction]()
    var transactionsByAmountDescending = [Transaction]()
    var transactionsByTimeAscending = [Transaction]()
    var transactionsByTimeDescending = [Transaction]()
    var transactionsByCategoryAscending = [Transaction]()
    var transactionsByCategoryDescending = [Transaction]()
    var transactionsToDiplay = [Transaction]()
    
    
    var state = 0
    //State 0 = addedByTime
    //State 1 = sortAmountAscendig
    //State 2 = sortAmountDescednging
    //State 3 = timeAscending
    //State 4 = timeDescending
    
    @IBOutlet weak var amountStack: UIStackView!
    @IBOutlet weak var timeStack: UIStackView!
    @IBOutlet weak var categoryStack: UIStackView!
    
    let moneyModel = MoneyModel()
    
    override func viewWillAppear(_ animated: Bool) {
        
        transactionsToDiplay = getTransactionToDisplay()
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(amountTapped))
        amountStack.addGestureRecognizer(tapRecognizer)
        
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(yearTapped))
        timeStack.addGestureRecognizer(tapRecognizer2)
        
        let tapRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(categoryTapped))
        categoryStack.addGestureRecognizer(tapRecognizer3)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactionsToDiplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell")!
        let categoryLabel = cell.viewWithTag(1) as? UILabel
        let dateLabel = cell.viewWithTag(2) as? UILabel
        let amountLabel = cell.viewWithTag(3) as? UILabel
        let imageView = cell.viewWithTag(4) as? UIImageView
        
        
        let transaction = transactionsToDiplay[indexPath.row]
        //* -1 + transactionsToDiplay.count - 1
        
        if let actualLabel = categoryLabel {
            
            
            if let actualNote = transaction.note  {
                
             actualLabel.text = actualNote
                
                
            } else {
            
            actualLabel.text = transaction.currentCategory
            
            }
            
        }
        
        if let actualDateLabel = dateLabel {
            
            actualDateLabel.text = transaction.dateToDisplay
            
        }
        
        if let actualAmountLabel = amountLabel {
            
            if transaction.isExpense == true {
                actualAmountLabel.textColor = UIColor.red
            } else {
                actualAmountLabel.textColor = UIColor.green
            }
            
            actualAmountLabel.text = transaction.amountToDisplay
            
        }
        
        if let actualImageView = imageView {
            
            actualImageView.image = UIImage(named: transaction.currentCategory!)
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            if let indexToRemove = transactions.index(of: transactionsToDiplay[indexPath.row])
            {
                
                transactions.remove(at: indexToRemove)
                
                transactionsToDiplay.remove(at: indexPath.row)
                
                updateTransactions()
                
            }
        }
    }
    
    
    
    var selectedTransaction = Transaction()
    var selectedIndex: Int?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        selectedTransaction = transactionsToDiplay[indexPath.row]
        
        selectedIndex = transactions.index(of: selectedTransaction)
        
        performSegue(withIdentifier: "goToDetail", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let naVC = segue.destination as! UINavigationController
        
        let detailVC = naVC.viewControllers[0] as! TransactionDetailViewController
        
        detailVC.summaryVC = self
        
        detailVC.transaction = selectedTransaction
        
        detailVC.selectedIndex = selectedIndex
        
        
        
    }
    
    
    func updateTransactions() {
        
        
        
        transactionsByAmountAscending = moneyModel.sortByAmount(transactions: transactions)
        
        transactionsByAmountDescending = moneyModel.sortByAmountDes(transactions: transactions)
        
        transactionsByTimeAscending = moneyModel.sortByTime(transactions: transactions)
        
        transactionsByTimeDescending = moneyModel.sortByTimeDes(transactions: transactions)
        
        transactionsByCategoryAscending = moneyModel.sortByCategory(transactions : transactions)
        
        transactionsByCategoryDescending = moneyModel.sortByCategoryDes(transactions: transactions)
        
        myTableView.reloadData()
        
    }
    
    
    
    
    func getTransactionToDisplay() -> [Transaction] {
        
        updateTransactions()
        
        switch state {
        case 0:
            return transactions
        case 1:
            return transactionsByAmountAscending
        case 2:
            return transactionsByAmountDescending
        case 3:
            return transactionsByTimeAscending
        case 4:
            return transactionsByTimeDescending
        case 5:
            return transactionsByCategoryAscending
        case 6:
            return transactionsByCategoryDescending
        default:
            print("State error")
            break
        }
        
        print("State error")
        return transactions
        
    }
    
    @IBOutlet weak var amount: UIButton!
    @IBOutlet weak var amountDes: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var timeDes: UIButton!
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var categoryDes: UIButton!
    
    func amountTapped(){
        
        resetButtons()
        
        if state == 1 {
            transactionsToDiplay = moneyModel.sortByAmountDes(transactions: transactions)
            state = 2
            amountDes.alpha = 0.3
            
        } else {
            transactionsToDiplay = moneyModel.sortByAmount(transactions: transactions);
            state = 1
            amount.alpha = 0.3
        }
        myTableView.reloadData();
        
        
    }
    
    func yearTapped(){
        
        resetButtons()
        
        if state == 3 {
             transactionsToDiplay = moneyModel.sortByTimeDes(transactions: transactions)
            state = 4
            timeDes.alpha = 0.3
        } else {
            transactionsToDiplay = moneyModel.sortByTime(transactions: transactions)
            state = 3
            time.alpha = 0.3
            
        }
        
       
        myTableView.reloadData()
        
    }
    
    func categoryTapped(){
        
        resetButtons()
        
        if state == 5 {
            transactionsToDiplay = moneyModel.sortByCategoryDes(transactions: transactions)
            state = 6
            categoryDes.alpha = 0.3
        } else {
            transactionsToDiplay = moneyModel.sortByCategory(transactions: transactions)
            state = 5
            category.alpha = 0.3
            
        }
        
        
        myTableView.reloadData()
        

    }
    
    func resetButtons () {
        
        amount.alpha = 1
        amountDes.alpha = 1
        time.alpha = 1
        timeDes.alpha = 1
        category.alpha = 1
        categoryDes.alpha = 1
        
    }
    
    
    
    
    
    
    
    
    
    
    let pickerLaucher = PickerLauncher()
    
    @IBAction func chooseBankAccount(_ sender: Any) {
        
            pickerLaucher.showPicker()
        
        }
        

       
        
        
        
    }

    

