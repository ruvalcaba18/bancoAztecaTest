

import UIKit
import Foundation

class MovieViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var vistaWeb: UIWebView!
    
    @IBOutlet var activityResult: UIActivityIndicatorView!
    var pagina: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityResult.startAnimating()

    }
    override func viewWillAppear(_ animated: Bool) {
        print("pagina \(pagina)")

        vistaWeb.loadRequest(URLRequest(url: URL(string: pagina)!))

    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityResult.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityResult.stopAnimating()
        activityResult.hidesWhenStopped = true
    }

}
