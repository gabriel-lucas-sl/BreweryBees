//
//  Database.swift
//  BreweryBess
//
//  Created by Danilo Rodrigues da Silva on 21/02/22.
//

import Foundation
import RealmSwift

public struct QueryStruct {
    let field: String
    let value: String
    let comparison: String
    let condition: String?
}

public typealias SelectQuery = QueryStruct

public class Database {
    func insert(_ object: Object) throws {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            throw error
        }
    }
    
    func select<T: Object>(_ object: T.Type,
                           sorted: Bool? = false,
                           sortBy: String? = "",
                           isAsc: Bool? = true,
                           query: [SelectQuery]? = []) -> Results<T>? {
        
        let realm = try! Realm()
        
        lazy var result = realm.objects(object)
        
        if sorted! {
            result = result.sorted(byKeyPath: sortBy!, ascending: isAsc!)
        }
        
        if (query?.count ?? 0) > 0 {
            var searchString = ""
            
            query?.forEach { param in
                searchString += "\(param.field) \(param.comparison) '\(param.value)' \(param.condition ?? "") "
            }
            result = result.filter(searchString)
        }
        
        return result
    }
    
    func selectFirst<T: Object>(_ object: T.Type,
                                sorted: Bool? = false,
                                sortBy: String? = "",
                                isAsc: Bool? = true,
                                query: [SelectQuery]? = []) -> T? {
        
        guard var result = self.select(object, sorted: sorted, sortBy: sortBy, isAsc: isAsc, query: query) else {
            return nil
        }
        
        return result.first ?? nil
    }
    
    func delete(_ object: Object, id: String) throws {
        
        let realm = try! Realm()
        
        do {
            lazy var result = realm.object(ofType: type(of: object), forPrimaryKey: id)
            
            if let deleteObj = result {
                try realm.write {
                    realm.delete(deleteObj)
                }
            } else {
                return
            }
        } catch {
            throw error
        }
    }
}
