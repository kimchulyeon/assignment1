//
//  CoreDataManager.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/29/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private var context: NSManagedObjectContext {
        return AppDelegate.persistentContainer.viewContext
    }

    private init() { }

    func saveSearchedHistory(searchText: String, searchType: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SearchHistory")
        fetchRequest.predicate = NSPredicate(format: "searchText == %@ AND searchType == %@", searchText, searchType)

        do {
            let fetchResults = try context.fetch(fetchRequest)

            // 중복되는 데이터가 없을 경우에만 새로 저장
            if fetchResults.isEmpty {
                let entity = NSEntityDescription.insertNewObject(forEntityName: "SearchHistory", into: context)
                entity.setValue(searchText, forKey: "searchText")
                entity.setValue(searchType, forKey: "searchType")
                try context.save()
            }
        } catch let error {
            print("Failed: \(error)")
        }
    }

    func getSearchedHistoryListFromDB() -> [(searchText: String, searchType: String)] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")

        var searchHistories: [(searchText: String, searchType: String)] = []

        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let searchText = data.value(forKey: "searchText") as? String ?? ""
                let searchType = data.value(forKey: "searchType") as? String ?? ""
                searchHistories.append((searchText, searchType))
            }
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return searchHistories
    }

    func deleteSearchedHistory(searchText: String, searchType: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SearchHistory")
        fetchRequest.predicate = NSPredicate(format: "searchText == %@ AND searchType == %@", searchText, searchType)

        do {
            let result = try context.fetch(fetchRequest)
            for object in result as! [NSManagedObject] {
                context.delete(object)
            }

            try context.save()
        } catch let error {
            print("Failed to delete record: \(error)")
        }
    }


    func deleteAllSearchedHistory() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SearchHistory")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
        } catch let error {
            print("Failed to delete all records: \(error)")
        }
    }

    func deleteSearchedHistory(at index: Int) {
        let allHistories = getSearchedHistoryListFromDB()
        if index < 0 || index >= allHistories.count {
            print("Invalid index")
            return
        }
        
        let historyToDelete = allHistories[index]
        deleteSearchedHistory(searchText: historyToDelete.searchText, searchType: historyToDelete.searchType)
    }
}

