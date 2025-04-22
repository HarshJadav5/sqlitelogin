//
//  database.swift
//  sqlitelogin
//
//  Created by Pravesh SmartTechnica on 15/04/25.
//

import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    
    var db: Connection?
    let usersTable = Table("users")
    
    let id = Expression<Int64>("id")
    let username = Expression<String>("username")
    let password = Expression<String>("password")
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            db = try Connection(fileUrl.path)
            createTable()
        } catch {
            print("Error connecting to database: \(error)")
        }
    }
    
    func createTable() {
        let create = usersTable.create(ifNotExists: true) { table in
            table.column(id, primaryKey: .autoincrement)
            table.column(username, unique: true)
            table.column(password)
        }
        
        do {
            try db?.run(create)
            print("Users table created")
        } catch {
            print("Table creation failed: \(error)")
        }
    }
    // Register User
    
    func registerUser(username: String, password: String) -> Bool {
        do {
            let insert = usersTable.insert(self.username <- username, self.password <- password)
            try db?.run(insert)
            print("User registered successfully")
            return true
        } catch {
            print("Registration is failed: \(error)")
            return false
        }
    }

    //  Login User
    
    func loginUser(username: String, password: String) -> Bool {
        do {
            let query = usersTable.filter(self.username == username && self.password == password)
            let result = try db?.pluck(query)
            if result != nil {
                print("Login successful")
                return true
            } else {
                print("Invalid username or password")
                return false
            }
        } catch {
            print("Login failed: \(error)")
            return false
        }
    }
 
}
