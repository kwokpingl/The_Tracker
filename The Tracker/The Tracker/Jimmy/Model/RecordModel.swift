//
//  RecordModel.swift
//  The Tracker
//
//  Created by Jimmy on 2018/2/24.
//  Copyright © 2018年 WSJ. All rights reserved.
//

import Foundation
import CoreLocation
struct RecordModel {
    var startDate:Date
    var endDate:Date
    var pace:Double
    var description:String
    var coordinate:CLLocation
    var lat:Double
    var lng:Double
    
    init?(json:[String:Any]) {
        
        guard let startDate = json[RecordModelKey.startDate] as? Date,
            let endDate = json[RecordModelKey.endDate] as? Date,
            let pace = json[RecordModelKey.pace] as? Double,
            let description = json[RecordModelKey.description] as? String,
            let lat = json[RecordModelKey.lat] as? Double,
            let lng = json[RecordModelKey.lng] as? Double
            else {
                return nil
        }
        
        self.startDate = startDate
        self.endDate = endDate
        self.pace = pace
        self.description = description
        self.lat = lat
        self.lng = lng
        self.coordinate = CLLocation(latitude: lat, longitude: lng)
    }
    
}
