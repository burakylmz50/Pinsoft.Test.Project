//
//  Connectivity.swift
//  PinsoftTestProject
//
//  Created by Burak Yılmaz on 24.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
