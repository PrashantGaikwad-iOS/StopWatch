//
//  ViewController.swift
//  Day 1 - Stop Watch App
//
//  Created by Prashant Gaikwad on 1/4/18.
//  Copyright © 2018 Prashant Gaikwad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var laps : [String] = []
    
    var timer = Timer()
    var minutes : Int = 0
    var seconds : Int = 0
    var fractions : Int = 0
    
    var stopWatchString : String = ""
    
    var startStopWatch : Bool = true
    var addLap : Bool = false
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopwatchLabel.text = "00:00.00"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateStopWatch() {
        
        fractions += 1
        
        if fractions == 100 {
            
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            
            minutes += 1
            seconds = 0
        }
        
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopWatchString = " \(minutesString):\(secondsString).\(fractionsString)"
        stopwatchLabel.text = stopWatchString
        
    }
    
    
    @IBAction func startStopAction(_ sender: Any) {
        
        if startStopWatch == true {
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            
            startStopWatch = false
            
            startStopButton.setTitle("STOP", for: .normal)
            lapResetButton.setTitle("LAP", for: .normal)
            
            addLap = true
        }else{
            
            timer.invalidate()
            
            startStopWatch = true
            
            startStopButton.setTitle("START", for: .normal)
            lapResetButton.setTitle("RESET", for: .normal)
            
            addLap = false
            
        }
        
    }
    
    @IBAction func lapResetAction(_ sender: Any) {
        
        if  addLap == true {
            
            laps.insert(stopWatchString, at: 0)
            lapsTableView.reloadData()
        }
        else{
            
            addLap = false
            lapResetButton.setTitle("LAP", for: .normal)
            
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopWatchString = "00:00.00"
            stopwatchLabel.text = stopWatchString
        }
        
    }
    
    
    
}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.value1 , reuseIdentifier:"Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        return cell
    }
    
    
    
    
    
}








