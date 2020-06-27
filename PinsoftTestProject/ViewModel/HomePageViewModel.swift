//
//  HomePageViewModel.swift
//  PinsoftTestProject
//
//  Created by Burak Yılmaz on 27.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import Foundation

protocol HomePageViewModelDelegate{
    func homePagerequestCompleted()
}

class HomePageViewModel{
    var MyArray = [MyModel]()
    var delegate: HomePageViewModelDelegate?
    
}

extension HomePageViewModel{
    func getData(a:String,completionHandler:@escaping([MyModel])-> ()){
        
        var urlString = a.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        var request = URLRequest(url: URL(string: "http://www.omdbapi.com/?t=" + urlString! + "+&apikey=e52966d3&type=movie")!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try? Data(contentsOf: request.url!)
        
        do {
            let json = try? JSONDecoder().decode(MyModel.self, from: data!)
            MyArray.append(json!)
        }
        completionHandler(MyArray)
        self.delegate?.homePagerequestCompleted()
    }
    
}
