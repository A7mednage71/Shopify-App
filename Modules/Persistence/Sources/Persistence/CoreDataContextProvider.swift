//
//  CoreDataContextProvider.swift
//  Persistence
//
//  Created by Eslam Elnady on 30/06/2026.
//

import CoreData

public protocol CoreDataContextProvider: Sendable {
    var viewContext: NSManagedObjectContext { get }
    func newBackgroundContext() -> NSManagedObjectContext
}
