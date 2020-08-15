

import Foundation
import UIKit
import CoreData
class CDHandler :NSObject{
    
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func fetchData() ->[FavoriteShows]?{
        let context = getContext()
        var shows: [FavoriteShows]? = nil;
        do{
            shows = try context.fetch(FavoriteShows.fetchRequest())
            return shows
        }catch let error as NSError{
            
            print("error \(error.localizedDescription)")
            return shows
        }
    }
    
    
}
