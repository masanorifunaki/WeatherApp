//
//  ViewController.swift
//  WeatherApp
//
//  Created by 舟木正憲 on 2018/12/30.
//  Copyright © 2018 masanori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var forecasts = [Forcecast]()

    @IBOutlet var weatherTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        Forecaster.forecast(cityName: "tokyo") {(result) in
            self.forecasts = result.list
            DispatchQueue.main.sync {
                self.weatherTableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            detailVC.forecast = sender as? Forcecast
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)

        let timeLabel = cell.viewWithTag(1) as? UILabel
        timeLabel?.text = forecasts[indexPath.row].dt_txt

        let iconLabel = cell.viewWithTag(2) as? UILabel
        iconLabel?.text = forecasts[indexPath.row].getIconText()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MainToDetail", sender: forecasts[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

