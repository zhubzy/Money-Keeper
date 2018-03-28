//
//  MoneyModel.swift
//  Money Keeper
//
//  Created by Zach Zhong on 10/07/2017.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class MoneyModel: NSObject {
    
    
    
    func getBalance (transactions: [Transaction]) -> Double {
        
        var balance: Double = 0
        
        
        for transaction in transactions {
            
            
            if transaction.isExpense == true {
                
                //If the amount is expense, make it negative
                balance += transaction.amount! * -1
                
            } else {
                
                //Transaction is postive
                balance += transaction.amount!
            }
        }
        
        
        return balance
        
    }
    
    
    
    
    
    func sortByAmount (transactions: [Transaction]) -> [Transaction] {
        
        
        if transactions.count == 0 {
            
            return transactions
        }
        
        var transactionToSort = transactions
        var currentTransaction: Transaction!
        var sortedTransaction = [Transaction]()
        
        
        for index in 0...transactionToSort.count - 1 {
            
            //Get a value to sort
            currentTransaction = transactionToSort[0]
            
            //Loop to compared that value to all the other transactions
            for transaction in transactionToSort {
                
                if currentTransaction.amount! <= transaction.amount! {
                    
                    //Prevent index out of range
                    if sortedTransaction.count - 1 >= index {
                        sortedTransaction.remove(at: index)
                    }
                    
                    //Prevent index out of range
                    if sortedTransaction.count >= index {
                        sortedTransaction.insert(transaction, at: index)
                    }
                    
                    //Set the value of the sort condition
                    currentTransaction = transaction
                    
                }
                
            }
            
            //Remove the biggest/smallest value found
            let indexToRemove = transactionToSort.index(of: currentTransaction)
            
            //Prevent crash
            if let actualIndexToRemove = indexToRemove {
                transactionToSort.remove(at: actualIndexToRemove)
                
            }
            
            
        }
        
        return sortedTransaction
        
        
        
    }
    
    func sortByAmountDes (transactions: [Transaction]) -> [Transaction] {
        
        
        if transactions.count == 0 {
            
            return transactions
        }
        
        var transactionToSort = transactions
        var currentTransaction: Transaction!
        var sortedTransaction = [Transaction]()
        
        
        for index in 0...transactionToSort.count - 1 {
            
            //Get a value to sort
            currentTransaction = transactionToSort[0]
            
            //Loop to compared that value to all the other transactions
            for transaction in transactionToSort {
                
                if currentTransaction.amount! >= transaction.amount! {
                    
                    //Prevent index out of range
                    if sortedTransaction.count - 1 >= index {
                        sortedTransaction.remove(at: index)
                    }
                    
                    //Prevent index out of range
                    if sortedTransaction.count >= index {
                        sortedTransaction.insert(transaction, at: index)
                    }
                    
                    //Set the value of the sort condition
                    currentTransaction = transaction
                    
                }
                
            }
            
            //Remove the biggest/smallest value found
            let indexToRemove = transactionToSort.index(of: currentTransaction)
            
            //Prevent crash
            if let actualIndexToRemove = indexToRemove {
                transactionToSort.remove(at: actualIndexToRemove)
                
            }
            
            
        }
        
        return sortedTransaction
        
    }
    
    
    func sortByTime (transactions: [Transaction]) -> [Transaction] {
        
        
        if transactions.count == 0 {
            
            return transactions
        }
        
        var transactionToSort = transactions
        var currentTransaction: Transaction!
        var sortedTransaction = [Transaction]()
        
        
        for index in 0...transactionToSort.count - 1 {
            
            
            
            
            //Get a value to sort
            currentTransaction = transactionToSort[0]
            
            //Loop to compared that value to all the other transactions
            innerloop: for transaction in transactionToSort {
                
                func save () {
                    
                    
                    //Prevent index out of range
                    if sortedTransaction.count - 1 >= index {
                        sortedTransaction.remove(at: index)
                    }
                    
                    //Prevent index out of range
                    if sortedTransaction.count >= index {
                        sortedTransaction.insert(transaction, at: index)
                    }
                    
                    //Set the value of the sort condition
                    currentTransaction = transaction
                    
                    
                }
                
                if currentTransaction.year! < transaction.year! {
                    
                    save()
                    
                } else if currentTransaction.year! == transaction.year! {
                    
                    if currentTransaction.month! < transaction.month! {
                        
                        save()
                        
                    } else if currentTransaction.month! == transaction.month! {
                        
                        if currentTransaction.date! <= transaction.date! {
                            
                            save()
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            //Remove the biggest/smallest value found
            let indexToRemove = transactionToSort.index(of: currentTransaction)
            
            //Prevent crash
            if let actualIndexToRemove = indexToRemove {
                transactionToSort.remove(at: actualIndexToRemove)
                
            }
            
            
        }
        
        return sortedTransaction
        
        
        
        
    }
    func sortByTimeDes (transactions: [Transaction]) -> [Transaction] {
        
        
        if transactions.count == 0 {
            
            return transactions
        }
        
        var transactionToSort = transactions
        var currentTransaction: Transaction!
        var sortedTransaction = [Transaction]()
        
        
        for index in 0...transactionToSort.count - 1 {
            
            
            
            
            //Get a value to sort
            currentTransaction = transactionToSort[0]
            
            //Loop to compared that value to all the other transactions
            innerloop: for transaction in transactionToSort {
                
                func save () {
                    
                    
                    //Prevent index out of range
                    if sortedTransaction.count - 1 >= index {
                        sortedTransaction.remove(at: index)
                    }
                    
                    //Prevent index out of range
                    if sortedTransaction.count >= index {
                        sortedTransaction.insert(transaction, at: index)
                    }
                    
                    //Set the value of the sort condition
                    currentTransaction = transaction
                    
                    
                }
                
                if currentTransaction.year! > transaction.year! {
                    
                    save()
                    
                } else if currentTransaction.year! == transaction.year! {
                    
                    if currentTransaction.month! > transaction.month! {
                        
                        save()
                        
                    } else if currentTransaction.month! == transaction.month! {
                        
                        if currentTransaction.date! >= transaction.date! {
                            
                            save()
                        }
                        
                    }
                    
                    
                }
                
                
            }
            
            //Remove the biggest/smallest value found
            let indexToRemove = transactionToSort.index(of: currentTransaction)
            
            //Prevent crash
            if let actualIndexToRemove = indexToRemove {
                transactionToSort.remove(at: actualIndexToRemove)
                
            }
            
            
        }
        
        return sortedTransaction
        
        
        
        
    }
    func sortByCategory (transactions: [Transaction]) -> [Transaction] {
        
        
        if transactions.count == 0 {
            
            return transactions
        }
        
        var transactionToSort = transactions
        var currentTransaction: Transaction!
        var sortedTransaction = [Transaction]()
        var otherTransaction = [Transaction]()
        
        
        
        //Remove other because we want it to be sorted last
        for transaction in transactionToSort {
            if transaction.currentCategory == "Other"{
                otherTransaction.append(transaction)
                transactionToSort.remove(at: transactions.index(of: transaction)!)
            }
            
        }
        
        
        
        
        for index in 0...transactionToSort.count - 1 {
            
            //Get a value to sort
            currentTransaction = transactionToSort[0]
            
            //Loop to compared that value to all the other transactions
            for transaction in transactionToSort {
                
                if currentTransaction.currentCategory! >= transaction.currentCategory! {
                    
                    //Prevent index out of range
                    if sortedTransaction.count - 1 >= index {
                        sortedTransaction.remove(at: index)
                    }
                    
                    //Prevent index out of range
                    if sortedTransaction.count >= index {
                        sortedTransaction.insert(transaction, at: index)
                    }
                    
                    //Set the value of the sort condition
                    currentTransaction = transaction
                    
                }
                
            }
            
            //Remove the biggest/smallest value found
            let indexToRemove = transactionToSort.index(of: currentTransaction)
            
            //Prevent crash
            if let actualIndexToRemove = indexToRemove {
                transactionToSort.remove(at: actualIndexToRemove)
                
            }
            
            
        }
        
        
        sortedTransaction += otherTransaction
        
        return sortedTransaction
        
    }
    
    func sortByCategoryDes (transactions: [Transaction]) -> [Transaction] {
        
        
        if transactions.count == 0 {
            
            return transactions
        }
        
        var transactionToSort = transactions
        var currentTransaction: Transaction!
        var sortedTransaction = [Transaction]()
        var otherTransaction = [Transaction]()
        
        
        
        //Remove other because we want it to be sorted last
        for transaction in transactionToSort {
            if transaction.currentCategory == "Other"{
                otherTransaction.append(transaction)
                transactionToSort.remove(at: transactions.index(of: transaction)!)
            }
            
        }
        
        
        for index in 0...transactionToSort.count - 1 {
            
            //Get a value to sort
            currentTransaction = transactionToSort[0]
            
            //Loop to compared that value to all the other transactions
            for transaction in transactionToSort {
                
                if currentTransaction.currentCategory! <= transaction.currentCategory! {
                    
                    //Prevent index out of range
                    if sortedTransaction.count - 1 >= index {
                        sortedTransaction.remove(at: index)
                    }
                    
                    //Prevent index out of range
                    if sortedTransaction.count >= index {
                        sortedTransaction.insert(transaction, at: index)
                    }
                    
                    //Set the value of the sort condition
                    currentTransaction = transaction
                    
                }
                
            }
            
            //Remove the biggest/smallest value found
            let indexToRemove = transactionToSort.index(of: currentTransaction)
            
            //Prevent crash
            if let actualIndexToRemove = indexToRemove {
                transactionToSort.remove(at: actualIndexToRemove)
                
            }
            
            
        }
        
        sortedTransaction += otherTransaction
        return sortedTransaction
        
    }
    
    func getTransactionsByCategory(isExpense: Bool,transactions:[Transaction]) -> [[String:Any]]{
        
        
        
        
        
        var result = [[String:Any]]()
        var transactionsToSort : [Transaction]
        var totalAmount = 0.0
        
        
        if transactions.count == 0 {
            
            return result
            
        }
        
        
        
        if isExpense == true {
        
            transactionsToSort = getTransactions(isExpense: true, transactions: transactions)
            
        } else {
            
            transactionsToSort = getTransactions(isExpense: false, transactions: transactions)
        }
        
        
        for transaction in transactionsToSort {

            var valueChanged = false
            totalAmount += transaction.amount!

            if result.count != 0 {
            innerloop: for index in 0...result.count - 1{
                
                if transaction.currentCategory == result[index]["Category Name"] as? String {
                    
                    
                    if let oldValue = result[index].updateValue(transaction.amount!, forKey: "Amount") as? Double  {
                        
                        result[index]["Amount"] = transaction.amount! + oldValue

                        
                        
                        valueChanged = true
                        
                        break innerloop
                        
                        
                    }
                    
                    
                
                
                }
            }
            }
            
            if valueChanged == false {
                
                
                result.append(["Category Name":transaction.currentCategory!,"Amount":transaction.amount!])
                
            }
            
            
        
        
            
        }
        
        
        //Calaculate the percentage
        for index in 0...result.count - 1 {
            
            result[index]["Percentage"] = result[index]["Amount"] as! Double / totalAmount
            
        }
        
        
        return result
        
    }
    

    
    private func getTransactions(isExpense: Bool,transactions:[Transaction]) -> [Transaction]{
        
        var expenseTransaction = [Transaction]()
        var incomeTransaction = [Transaction]()
        
        
        for transaction in transactions {
            
            if transaction.isExpense == true {
                
                expenseTransaction.append(transaction)
                
            } else {
                
                incomeTransaction.append(transaction)
                
            }
            
            
        }
        
        if isExpense == true {
            
            return expenseTransaction
            
        } else {
            
            return incomeTransaction
            
        }
        
    }
    
    
}
