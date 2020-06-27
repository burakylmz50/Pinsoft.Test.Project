//
//  CollectionViewCell.swift
//  PinsoftTestProject
//
//  Created by Burak Yılmaz on 25.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let posterImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.darkGray
        return image
    }()
    
    private func  posterImageContraints(){
        self.contentView.addSubview(posterImage)
        posterImage.layer.masksToBounds = true
        posterImage.layer.cornerRadius = 15.0
        posterImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    let posterImageBack : UILabel = {
           let imageBack = UILabel()
        imageBack.textColor = UIColor.red
           return imageBack
       }()
       
       private func  posterImageBackContraints(){
           self.posterImage.addSubview(posterImageBack)
           posterImage.snp.makeConstraints { (make) in
               make.centerX.equalToSuperview()
               make.centerY.equalToSuperview()
               make.height.equalTo(50)
               make.width.equalTo(50)
           }
       }
    
  
    
    

    override init(frame : CGRect){
        super.init(frame : frame)
        posterImageContraints()
        posterImageBackContraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        DispatchQueue.main.async {
            self.posterImage.layer.cornerRadius = 13.0
            self.posterImage.layer.shadowColor = UIColor.gray.cgColor
            self.posterImage.layer.shadowOpacity = 0.5
            self.posterImage.layer.shadowOpacity = 10.0
            self.posterImage.layer.shadowOffset = .zero
            self.posterImage.layer.shadowPath = UIBezierPath(rect: self.posterImage.bounds).cgPath
            self.posterImage.layer.shouldRasterize = true
            
        }
        
    }
    
    
}
