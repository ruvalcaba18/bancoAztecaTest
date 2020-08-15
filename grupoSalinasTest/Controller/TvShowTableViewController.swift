

import UIKit
import CoreData

@available(iOS 13.0, *)
class TvShowTableViewController: UITableViewController{
    
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    //MARK:= Constants
      let urlJsonString = "https://api.tvmaze.com/shows"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let  alertNotification = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    //MARK:= Variables
    
    var selectedIndex = IndexPath(row: 0, section: 0)
    var tv = [apiDecoder]()
    var selectedCells = [apiDecoder]()
    var items1: [FavoriteShows] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.activitiIndicator.stopAnimating()
        //TODO: Conexion a Api de peliculas
                guard let url = URL(string: urlJsonString)else{ return }
                      
                      URLSession.shared.dataTask(with: url) { (data, response, err) in
                        
                          guard let data = data else{return}
                          
                          do{

                              let information = try JSONDecoder().decode([apiDecoder].self, from: data)
                           
                              for info in information{
                                
                                  let tvShowInfo = apiDecoder(name:info.name , summary: info.summary, externals: info.externals, image: info.image)
                                  
                                  self.tv.append(tvShowInfo)
                                
                              }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                              
                          }catch let err{
                              print("We have this error  \(err.localizedDescription)")
                          }
                          
                      }.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitiIndicator.center = self.view.center;
            activitiIndicator.hidesWhenStopped = true;
            activitiIndicator.color = UIColor.blue
            activitiIndicator.style = UIActivityIndicatorView.Style.large
            
            activitiIndicator.startAnimating()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tv.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        
        cell.textLabel?.text = self.tv[indexPath.row].name!;
        let interpolation = self.tv[indexPath.row].image?.medium as! String;
        let url:NSURL = NSURL(string: interpolation)!
        
          let imageData:NSData = NSData.init(contentsOf: url as URL)!
          cell.imageView?.image = UIImage(data: imageData as Data)
          cell.imageView?.center = cell.center
        cell.imageView?.layer.cornerRadius = 10.0
        cell.imageView?.layer.masksToBounds = true
    
        return cell
    }

    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        
        let Add = UIContextualAction(style: .normal, title: "Add") { (action, view, completionHandler) in
                

            let nombres = apiDecoder(name: self.tv[indexPath.row].name, summary: self.tv[indexPath.row].summary, externals: self.tv[indexPath.row].externals, image: self.tv[indexPath.row].image)
  

            let newData = FavoriteShows(context: self.context);
            newData.name = nombres.name!
            newData.imagen = nombres.image?.medium!
            newData.summary = nombres.summary!
            newData.externals = nombres.externals?.imdb!
                    
                    self.items1.append(newData)

            do{
                try self.context.save()


            }catch let error{
                print("error   \(error.localizedDescription)")
            }

    }
        
        Add.backgroundColor = UIColor.green
        let config = UISwipeActionsConfiguration(actions: [Add])
        config.performsFirstActionWithFullSwipe = false
        return config
}
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
    }
    
    
   
    }

    
