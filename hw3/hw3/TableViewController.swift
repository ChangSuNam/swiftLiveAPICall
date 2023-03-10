//
//  TableViewController.swift
//  hw3
//
//  Created by ChangSu Nam on 2/23/23.
//
import UIKit
import Foundation

class myCustomCell: UITableViewCell{
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel2: UILabel!
    
}

class TableViewController: UITableViewController {

    var allCity:[Welcome] = []
    //var allImages:[String: UIImage] = [:]
        
    // MARK: - Welcome
    struct Welcome: Codable {
        let location: Location
        let current: Current
    }
    // MARK: - Current
    struct Current: Codable {
        let lastUpdatedEpoch: Int
        let lastUpdated: String
        let tempC, tempF, isDay: Double
        let condition: Condition
        let windMph, windKph: Double
        let windDegree: Int
        let windDir: String
        let pressureMB: Int
        let pressureIn, precipMm, precipIn: Double
        let humidity, cloud: Int
        let feelslikeC, feelslikeF, visKM: Double
        let visMiles, uv: Int
        let gustMph, gustKph: Double

        enum CodingKeys: String, CodingKey {
            case lastUpdatedEpoch = "last_updated_epoch"
            case lastUpdated = "last_updated"
            case tempC = "temp_c"
            case tempF = "temp_f"
            case isDay = "is_day"
            case condition
            case windMph = "wind_mph"
            case windKph = "wind_kph"
            case windDegree = "wind_degree"
            case windDir = "wind_dir"
            case pressureMB = "pressure_mb"
            case pressureIn = "pressure_in"
            case precipMm = "precip_mm"
            case precipIn = "precip_in"
            case humidity, cloud
            case feelslikeC = "feelslike_c"
            case feelslikeF = "feelslike_f"
            case visKM = "vis_km"
            case visMiles = "vis_miles"
            case uv
            case gustMph = "gust_mph"
            case gustKph = "gust_kph"
        }
    }
    // MARK: - Condition
    struct Condition: Codable {
        let text, icon: String
        let code: Int
    }
    // MARK: - Location
    struct Location: Codable {
        let name, region, country: String
        let lat, lon: Double
        let tzID: String
        let localtimeEpoch: Int
        let localtime: String

        enum CodingKeys: String, CodingKey {
            case name, region, country, lat, lon
            case tzID = "tz_id"
            case localtimeEpoch = "localtime_epoch"
            case localtime
        }
    }
    
    
    
    
        
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        getAllData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCity.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCustomCell
        print(cell)
        // Configure the cell...
        cell.locationLabel.text = allCity[indexPath.row].location.name
        cell.temperatureLabel.text = String(allCity[indexPath.row].current.tempC) + " Degree Celsius"
        cell.temperatureLabel2.text = String(allCity[indexPath.row].current.tempF) + " Degree Farenheits"
       
        
        return cell
    }
    

    
    func getAllData() {
        //let url = URL(string: "https://////")//replace with valid url
        let cityList = ["London","Paris","Seoul","Tokyo","New%20York","Madrid","Osaka","LA","Phoenix","Harrisburg"]
        
        for city in cityList{
            //print("https://weatherapi-com.p.rapidapi.com/current.json?q=\(city)")
            let headers = [
                "X-RapidAPI-Key": "85ab65a74cmsh6e6194ebe92ae49p1aee96jsn054e5de2f642",
                "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
            ]
            let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/current.json?q=\(city)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            //change to URLSession?
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                guard error == nil else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error - ", message: error?.localizedDescription, preferredStyle: .alert)
                        //let alert = UIAlertController(title: "Error - ", message: "\(error!)", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    return
                }
                guard let jsonData = data else {
                    print("No data")
                    return
                }

                do {//
                    let temp = try JSONDecoder().decode(Welcome.self, from: jsonData)
                    self.allCity.append(temp)
                    //self.allImages.append(temp.current.condition.icon)
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    //start again, run delegate methods again
                    }
                }catch{
                    print("JSON Decode error: \(error)")
                }
            })
            dataTask.resume()
        }//for
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            allCity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinIndexPath: IndexPath) {
        let curCity = allCity[fromIndexPath.row]
        allCity.remove(at: fromIndexPath.row)
        allCity.insert(curCity, at: destinIndexPath.row)
    }
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! detailViewController
        let selectedRow = tableView!.indexPathForSelectedRow
       
        destVC.location = allCity[selectedRow!.row].location.name
        destVC.temperatureC = String(allCity[selectedRow!.row].current.tempC) + " °C"
        destVC.temperatureF = String(allCity[selectedRow!.row].current.tempF) + " °F"
        destVC.temperatureFeelsLikeC = String(allCity[selectedRow!.row].current.feelslikeC) + " °C"
        destVC.temperatureFeelsLikeF = String(allCity[selectedRow!.row].current.feelslikeF) + " °F"
       
        destVC.wind = String(allCity[selectedRow!.row].current.windMph) + " mph"
        
        
        
        
    }
    

}
