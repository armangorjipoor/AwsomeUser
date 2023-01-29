//
//  UserRepository.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/7/1401 AP.
//

import Foundation
import CoreData

protocol UserRepository {
    func create(user: User)
    func getAll() -> [User]?
    func get(byIdentifier id: UUID) -> User?
    func update(user: User)
    func delete(record: User)
}

struct UserDataRepository: UserRepository {
    func create(user: User) {
        let cdUsr = CDUser(context: PersistentStorage.shared.context)
        cdUsr.fullName = user.fullName
        cdUsr.userName = user.userName
        cdUsr.password = user.password
        cdUsr.id = user.id
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [User]? { nil }
    
    func get(byIdentifier id: UUID) -> User? {

            let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
            let predicate = NSPredicate(format: "id==%@", id as CVarArg)

            fetchRequest.predicate = predicate
            do {
                let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

                guard result != nil else {return nil}

                return result?.convertToUser()

            } catch let error {
                debugPrint(error)
            }

            return nil
        }
    
    func get(byUserName userName: String) -> User? {

            let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
            let predicate = NSPredicate(format: "userName==%@", userName as CVarArg)

            fetchRequest.predicate = predicate
            do {
                let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

                guard result != nil else {return nil}

                return result?.convertToUser()

            } catch let error {
                debugPrint(error)
            }

            return nil
        }
    
    func getUser(by userName: String, password: Int16) -> User? {
        let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
        let predicate = NSPredicate(format: "userName==%@ AND password==%i",
                                    userName as CVarArg,
                                    password as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}

            return result?.convertToUser()

        } catch let error {
            debugPrint(error)
        }

        return nil
    }
    
    func update(user: User) { }
    
    func delete(record: User) {}
    
    
}
