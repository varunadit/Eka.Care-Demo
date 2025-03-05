//
//  DBManager.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/5/25.
//

import CoreData

class DBManager {
        
    static let shared: DBManager = {
        let dbManager = DBManager()
        return dbManager
    }()
        
    private init() {
        let vcontext = PersistenceController.shared.container.viewContext
        self.managedObjectContext = vcontext
    }
    
    private var managedObjectContext: NSManagedObjectContext!
    
    func create<E: NSManagedObject>(proccess: (_ object: E) -> Void) -> Bool {
        do {
            proccess(NSEntityDescription.insertNewObject(forEntityName: "\(E.self)", into: managedObjectContext) as! E)
            
            try managedObjectContext.save()
            
            return true
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
        
    }
    
    func read<E: NSManagedObject>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?) -> [E] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        
        proccess?(fetchRequest)
        
        do {
            return try managedObjectContext.fetch(fetchRequest) as! [E]
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func read<E: NSManagedObject>(process: ((_ fetchRequest: NSFetchRequest<E>) -> Void)?) -> [E] {
        let fetchRequest = NSFetchRequest<E>(entityName: "\(E.self)")
        
        process?(fetchRequest)
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    
    func update<E: NSManagedObject>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?, update: (_ objects: [E]) -> Void) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        
        proccess?(fetchRequest)
        
        do {
            update(try managedObjectContext.fetch(fetchRequest) as! [E])
            try managedObjectContext.save()
            
            return true
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
        
    }
    
    func delete<E: NSManagedObject>(proccess: ((_ fetchRequest: NSFetchRequest<E>) -> Void)?, deletedObjects: ((_ objects: [E]) -> Void)?) -> Bool {
        let fetchRequest: NSFetchRequest<E> = E.fetchRequest() as! NSFetchRequest<E>
        
        proccess?(fetchRequest)
        
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            
            deletedObjects?(objects)
            
            for object in objects {
                managedObjectContext.delete(object)
            }
            
            try managedObjectContext.save()
            
            return true
        } catch let error {
            print("Deletion error: \(error.localizedDescription)")
            return false
        }
    }
}

