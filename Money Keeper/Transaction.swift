//
//  Transaction.swift
//  Money Keeper
//
//  Created by Zach Zhong on 7/3/17.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class Transaction: NSObject, NSCoding {
    var amount: Double?
    var amountToDisplay: String?
    var year: Int?
    var month: Int?
    var date: Int?
    var dateToDisplay: String?
    var isExpense: Bool?
    var currentCategory: String?
    var note: String?
    var categories = ["Cloth", "Electronic", "Entertainment", "Food", "Gas", "Grocery", "Health", "Rent", "Transportation", "Utility","Other"]
    var incomeCategories = ["Gift","Salary","Other"]
    var receiptImage : UIImage?
    
    required convenience init(coder aDecoder: NSCoder) {
        
        self.init()

         amount = aDecoder.decodeObject(forKey: "amount") as? Double
         amountToDisplay = aDecoder.decodeObject(forKey: "amountToDisplay") as? String
         year = aDecoder.decodeObject(forKey: "year") as? Int
         month = aDecoder.decodeObject(forKey: "month") as? Int
         date = aDecoder.decodeObject(forKey: "date") as? Int
         dateToDisplay = aDecoder.decodeObject(forKey: "dateToDisplay") as? String
         isExpense = aDecoder.decodeObject(forKey: "isExpense") as? Bool
         currentCategory = aDecoder.decodeObject(forKey: "currentCategory") as? String
         note = aDecoder.decodeObject(forKey: "note") as? String
        receiptImage = aDecoder.decodeObject(forKey: "receiptImage") as? UIImage
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(amount, forKey: "amount")
        aCoder.encode(amountToDisplay, forKey: "amountToDisplay")
        aCoder.encode(year, forKey: "year")
        aCoder.encode(month, forKey: "month")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(dateToDisplay, forKey: "dateToDisplay")
        aCoder.encode(isExpense, forKey: "isExpense")
        aCoder.encode(currentCategory, forKey: "currentCategory")
        aCoder.encode(note, forKey: "note")
        aCoder.encode(receiptImage,forKey: "receiptImage")

    }
   
    
    
}
