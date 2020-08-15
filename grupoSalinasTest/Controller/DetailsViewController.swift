
import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var titulo: UILabel!
    @IBOutlet var imageTv: UIImageView!
    @IBOutlet var detallesTv: UILabel!
    @IBOutlet var imdbLink: UIButton!

    var DataDetails: FavoriteShows?
    var sendPage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titulo.text = DataDetails!.name
        detallesTv.text = DataDetails!.summary
        
        let urltV:String =  (DataDetails!.externals!)
        self.sendPage = "https://www.imdb.com/title/" + urltV + "/";
        let url:NSURL = NSURL(string: DataDetails!.imagen!)!
              let imageData:NSData = NSData.init(contentsOf: url as URL)!
        imageTv.image = UIImage(data: imageData as Data)
        
        if (DataDetails?.externals!.isEmpty)!,DataDetails?.externals == nil{
            print("no tiene imdb")
            imdbLink.isHidden = true
            
        }else{

            imdbLink.isHidden = false
            imdbLink.addTarget(self, action: #selector(webDisplay), for: .touchUpInside)
            print(" tiene imdb")
        }
        
    }
    @objc func webDisplay(sender: UIButton!) {
       print("Button tapped")
        
        DispatchQueue.main.async {
         
            self.performSegue(withIdentifier: "imdbDisplay", sender: self)
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? MovieViewController{
            destino.pagina = sendPage
            print("Send PAGE \(sendPage)")
        }
    }
    


}
