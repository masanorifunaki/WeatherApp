//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by 舟木正憲 on 2018/12/30.
//  Copyright © 2018 masanori. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var forecast:Forcecast?

    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var iconLabel:UILabel!
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var descLabel:UILabel!
    @IBOutlet var tempLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = forecast?.dt_txt
        iconLabel.text = forecast?.getIconText()
        weatherLabel.text = forecast?.getMain()
        descLabel.text = forecast?.getDescription()
        tempLabel.text = forecast?.getFormattedTemp()
    }

}
