//
//  DataBaseManager.swift
//  The Tracker
//
//  Created by Jimmy on 2018/2/12.
//  Copyright © 2018年 WSJ. All rights reserved.
//

import Foundation
import CoreData

// 要寫連結 Database 的 API (寫入、讀取、修改、刪除)
// 還有要有 Database 的結構 (Key, Start Time, End Time, Pace, Start Longitude, Start Latitude, End Longitude, End Latitude, Description ... 可以再加)

class DataBaseManager {
    
    //MARK: - Core Data Stack Container
    // prepares core data for data requests and the creation of data
    fileprivate let stack = CoreDataStack()
    
    fileprivate let formatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    //MARK: - Add new track history 新增資料
    func newTrack(distance: Float, endDateTime: Date, startDateTime: Date, endLat: Double, endLng: Double, note: String, pace: Float, startLat: Double, startLng: Double, timeSpent: Int32) {
        
        let container = stack.persistentContainer
        let context = container.viewContext
        
        let cdm = NSEntityDescription.insertNewObject(forEntityName: DataBaseConstants.entity, into: context) as! TracksHistory
 
        cdm.distance = distance
        cdm.endDateTime = endDateTime as NSDate
        cdm.endLat = endLat
        cdm.endLng = endLng
        cdm.startDateTime = startDateTime as NSDate
        cdm.startLat = startLat
        cdm.startLng = startLng
        cdm.note = note
        cdm.pace = pace
        cdm.timeSpent = timeSpent
        
        stack.saveContext()
    }
    
    //MARK: FetchData 讀取資料
    func fetchData() -> [TracksHistory]{
        
        let container = stack.persistentContainer
        let context = container.viewContext
        let request : NSFetchRequest<TracksHistory> = TracksHistory.fetchRequest()
        
        do {
            let results = try context.fetch(request)
//            for result in results {
//                print(result)
//            }
            return results
            
        } catch {
            fatalError("Failed in fetching data: \(error)")
        }
    }
    
    //MARK: Delete Data 刪除資料
    func deleteData(_ startDateTime: Date) {
        
        // Covert Date to String in format
        let dateStr: String = formatter.string(from: startDateTime)
        
        let request : NSFetchRequest<TracksHistory> = TracksHistory.fetchRequest()
        let container = stack.persistentContainer
        let context = container.viewContext
        
        request.predicate = NSPredicate(format: "startDateTime CONTAINS[cd] %@", dateStr)
        
        do {
            
            let results = try context.fetch(request)
            print(results)
            
            for result in results {
                print(result)
                context.delete(result)
            }
            print("Data deleted.")
            stack.saveContext()
            
        } catch {
            print("Delete error occured: \(error)")
        }
    }
    
    //MARK: - Edit Data 修改資料
    func editData(_ dataToBeEdited: [String:Any]) {
        
        guard let endLng = dataToBeEdited[DataBaseConstants.endLng] as? Double else {
            print("Error in getting endLng from Dictionary")
            return
        }
        
        guard let endLat = dataToBeEdited[DataBaseConstants.endLat] as? Double else {
            print("Error in getting endLat from Dictionary")
            return
        }
        
        guard let startLng = dataToBeEdited[DataBaseConstants.startLng] as? Double else {
            print("Error in getting startLng from Dictionary")
            return
        }
        
        guard let startLat = dataToBeEdited[DataBaseConstants.startLat] as? Double else {
            print("Error in getting startLat from Dictionary")
            return
        }
        
        guard let note = dataToBeEdited[DataBaseConstants.note] as? String else {
            print("Error in getting note from Dictionary")
            return
        }
        
        guard let startDateTime = dataToBeEdited[DataBaseConstants.startDateTime] as? Date else {
            print("Error in getting startDateTime from Dictionary")
            return
        }
        
        let dateStr: String = formatter.string(from: startDateTime)
        
        let request : NSFetchRequest<TracksHistory> = TracksHistory.fetchRequest()
        let container = stack.persistentContainer
        let context = container.viewContext
        
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", dateStr)
        
        do {
            let results = try context.fetch(request)
            print(results)
            
            if results.count > 0 {
                let dataFetch = results[0]
                dataFetch.startLat = startLat
                dataFetch.startLng = startLng
                dataFetch.endLat = endLat
                dataFetch.endLng = endLng
                dataFetch.note = note
                
                stack.saveContext()
            }
            print("Data has been updated.")
            
        } catch {
            print("Data Editting error occured: \(error)")
        }
    }
}
