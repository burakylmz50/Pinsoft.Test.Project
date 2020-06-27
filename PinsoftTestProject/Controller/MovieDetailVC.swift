//
//  MovieDetailVC.swift
//  PinsoftTestProject
//
//  Created by Burak Yılmaz on 27.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class MovieDetailVC: UIViewController{
    
    var movieDetailArray = [MyModel]()
    
    
    private let scrollView = UIScrollView()
    private func setScrollView(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(view).offset(0)
        }
    }
    
    private let container = UIView()
    private func setContainer(){
        scrollView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.left.width.equalTo(scrollView)
            make.height.equalTo(1300)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }
    }
    
    private let posterImage : UIImageView = {
        let image = UIImageView()
        return image
    }()
    private func setPosterImage(){
        self.container.addSubview(posterImage)
        paddingPosterImage()
        posterImage.snp.makeConstraints { (make) in
            make.top.equalTo(container.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(450)
            make.width.equalTo(300)
        }
    }
    private func paddingPosterImage(){
        posterImage.layer.masksToBounds = true
        posterImage.layer.cornerRadius = 15.0
    }
    
    private let titleLabel : UILabel = {
        let title = UILabel()
        return title
    }()
    private func setTitleLabel(){
        self.container.addSubview(titleLabel)
        paddingtitleLabel()
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImage.snp.bottomMargin).offset(20)
            make.centerX.equalTo(container)
            make.height.equalTo(50)
        }
    }
    private func paddingtitleLabel(){
        titleLabel.textColor = UIColor.red
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        titleLabel.sizeToFit()
    }
    
    let yearLabel : UILabel = {
        let yearLabel = UILabel()
        yearLabel.textColor = UIColor.red
        return yearLabel
    }()
    
    private func  yearLabelContraints(){
        self.container.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    let ReleasedLabel : UILabel = {
        let ReleasedLabel = UILabel()
        ReleasedLabel.textColor = UIColor.red
        return ReleasedLabel
    }()
    
    private func  ReleasedLabelContraints(){
        self.container.addSubview(ReleasedLabel)
        ReleasedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(yearLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    let RuntimeLabel : UILabel = {
        let RuntimeLabel = UILabel()
        RuntimeLabel.textColor = UIColor.red
        return RuntimeLabel
    }()
    
    private func  RuntimeLabelContraints(){
        self.container.addSubview(RuntimeLabel)
        RuntimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ReleasedLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    let imdbRatingLabel : UILabel = {
        let imdbRatingLabel = UILabel()
        imdbRatingLabel.textColor = UIColor.red
        return imdbRatingLabel
    }()
    
    private func  imdbRatingLabelContraints(){
        self.container.addSubview(imdbRatingLabel)
        imdbRatingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(RuntimeLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    let WriterLabel : UILabel = {
        let WriterLabel = UILabel()
        WriterLabel.textColor = UIColor.red
        return WriterLabel
    }()
    
    private func  WriterLabelContraints(){
        self.container.addSubview(WriterLabel)
        WriterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imdbRatingLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    let LanguageLabel : UILabel = {
        let LanguageLabel = UILabel()
        LanguageLabel.textColor = UIColor.red
        return LanguageLabel
    }()
    
    private func  LanguageLabelContraints(){
        self.container.addSubview(LanguageLabel)
        LanguageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(WriterLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    let CountryLabel : UILabel = {
        let CountryLabel = UILabel()
        CountryLabel.textColor = UIColor.red
        return CountryLabel
    }()
    
    private func  CountryLabelContraints(){
        self.container.addSubview(CountryLabel)
        CountryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(LanguageLabel.snp.bottom).offset(20)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    
    func UI(){
        view.backgroundColor = .black
        setScrollView()
        setContainer()
        setPosterImage()
        setTitleLabel()
        yearLabelContraints()
        ReleasedLabelContraints()
        RuntimeLabelContraints()
        imdbRatingLabelContraints()
        WriterLabelContraints()
        LanguageLabelContraints()
        CountryLabelContraints()
    }
    func placement(){
        posterImage.loadImageAsync(with: movieDetailArray[0].poster, completed: {
            
        })
        titleLabel.text = movieDetailArray[0].title
        yearLabel.text = "YEAR: " + movieDetailArray[0].year!
        RuntimeLabel.text = "Runtime: " + movieDetailArray[0].runtime!
        ReleasedLabel.text = "Released: " + movieDetailArray[0].released!
        imdbRatingLabel.text = "IMDB Rating: " + movieDetailArray[0].imdbRating!
        WriterLabel.text = "Writer: " + movieDetailArray[0].writer!
        LanguageLabel.text = "Language: " + movieDetailArray[0].language!
        CountryLabel.text = "Country: " + movieDetailArray[0].country!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        placement()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
    }
    
}
