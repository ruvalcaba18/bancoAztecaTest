

import UIKit
import CoreData

class FavoriteTableViewController: UITableViewController{
    
    //MARK:= Variables
    var items2 = [FavoriteShows]()
    var selectedIndex = IndexPath(row: 0, section: 0)
    
    //MARK:= Constants
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    print("\(items2)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "favoriteDetails", sender: self)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items2.count 
    }

    
   override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

             
             let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
                 
                let personToRemove = self.items2[indexPath.row]
                self.context.delete(personToRemove)
                do{
                    try self.context.save()
                }catch let error {
                    print("error \(error.localizedDescription)")
                }
                self.fetchData()
                self.tableView.reloadData()
             
         }
             
             delete.backgroundColor = UIColor.red
             let config = UISwipeActionsConfiguration(actions: [delete])
             config.performsFirstActionWithFullSwipe = false
             return config
     }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        
     
        let objeto = self.items2[indexPath.row].name
        
        let interpolation = self.items2[indexPath.row].imagen as! String;
               let url:NSURL = NSURL(string: interpolation)!

               cell.textLabel?.text = objeto
               
        let imageData:NSData = NSData.init(contentsOf: url as URL)!
                 cell.imageView?.image = UIImage(data: imageData as Data)
                 cell.imageView?.center = cell.center
               cell.imageView?.layer.cornerRadius = 10.0
               cell.imageView?.layer.masksToBounds = true
           
        
        return cell
    }
    
    // MARK:= Core Data funcs
    
    func fetchData(){
        
  let request = NSFetchRequest<FavoriteShows>(entityName: "FavoriteShows")
        request.returnsObjectsAsFaults = false
        
        do{
            self.items2 = try context.fetch(request)
            
            DispatchQueue.main.async {
                
              self.tableView.reloadData()
            }
        }catch let error as NSError{
            print("The error is \(error.localizedDescription)")
        }

        
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? DetailsViewController{
            destino.DataDetails = items2[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
}
 
 
