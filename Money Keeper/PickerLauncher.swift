//
//  PickerLauncher.swift
//  Money Keeper
//
//  Created by Zach Zhong on 8/1/17.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class PickerLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let selectionView = SelectionView()

    
    let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = UIColor.white
        
        return cv
        
    }()
    
    let cellId = "cellId"
    
    
    func showPicker(){
        if let window = UIApplication.shared.keyWindow{
            
            selectionView.frame = window.frame
            selectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(selectionView)
            window.addSubview(collectionView)
            
            let height:CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            self.selectionView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectionView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            
        }
    
    
    
    
    
    
    }
    
    func handleDismiss() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
             if let window = UIApplication.shared.keyWindow{
            self.selectionView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height , width: self.collectionView.frame.width, height: self.collectionView.frame.height )
            }
        })
        
    }
    
    override init() {
        
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CreditCardCell.self, forCellWithReuseIdentifier: cellId)
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    
    
}
