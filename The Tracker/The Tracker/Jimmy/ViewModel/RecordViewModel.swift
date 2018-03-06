//
//  SearchViewModel.swift
//  The Tracker
//
//  Created by Jimmy on 2018/2/24.
//  Copyright © 2018年 WSJ. All rights reserved.
//

import Foundation

class RecordViewModel {
    var listener:(([RecordModel])->())? = nil
    var models = [RecordModel]()
    
    //TODO: Fetch Data from CoreData
    func fetchDate() {
        
        //TODO: RETURN [RecordModel]
        listener?(models)
    }
    
    //TODO: Change Record with Certain Model
    func changeDate(recordModel:RecordModel) {
        
    }
    
    //TODO: Delete Record
    func deleteData(recordModel:RecordModel) {
        
    }
    
    //TODO: Save Record
    func saveData(recordModel:RecordModel) {
        
    }
}
