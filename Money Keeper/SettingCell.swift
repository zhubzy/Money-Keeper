//
//  SettingCell.swift
//  Money Keeper
//
//  Created by Zach Zhong on 8/1/17.
//  Copyright © 2017 Zach Zhong. All rights reserved.
//

import UIKit

class CreditCardCell: BaseCell {
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Bank Cards"
        return label
        
    }()
    
    let iconImageView: UIImageView = {
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "credit_card")
        imageView.contentMode = .scaleAspectFit
        return imageView
        
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        
    }
}













class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        
    }
}




extension UIView {
    
    func addConstraintsWithFormat(format:String, views: UIView...){
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
            
            
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
    
    
    
    
}
