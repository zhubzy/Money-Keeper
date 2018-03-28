//
//  ImagePickerView.swift
//  Money Keeper
//
//  Created by Zach Zhong on 10/07/2017.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class ImagePickerView: UIView {

 
    func makeview(category: [String], row: Int, width: CGFloat) -> UIView {
    
        let imagePickerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 60))
        let imageVIew = UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 50))
        let label = UILabel(frame: CGRect(x: width / 2 - 50, y: 0, width: 150, height: 60))
     
        
        
        label.text = category[row]
        imageVIew.image = UIImage(named: category[row])
        
        
        imagePickerView.addSubview(imageVIew)
        imageVIew.addSubview(label)
        
        return imagePickerView
    }
    
    
}
