//
//  detailViewController.swift
//  hw3
//
//  Created by ChangSu Nam on 2/23/23.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel2: UILabel!
    @IBOutlet weak var feelsLikeFLabel: UILabel!
    @IBOutlet weak var feelsLikeCLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    
    
    var location: String = ""
    var temperatureC: String = ""
    var temperatureF: String = ""
    var temperatureFeelsLikeC: String = ""
    var temperatureFeelsLikeF: String = ""
    var wind: String = ""
    //var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationLabel.text = location
        temperatureLabel.text = temperatureC
        feelsLikeCLabel.text = temperatureFeelsLikeC
        temperatureLabel2.text = temperatureF
        feelsLikeFLabel.text = temperatureFeelsLikeF
        windLabel.text = wind
        //weatherImage.image = image
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





