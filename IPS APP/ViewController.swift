//
//  ViewController.swift
//  IPS APP
//
//  Created by  on 1/3/18.
//  Copyright © 2018 Dirty Sanchez Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
// Outlets and vars
    @IBOutlet weak var myTable: UITableView!
   
    var list:[String] = []
    var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elasped: Double = 0
    var status: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        resetButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
       list = ["videoOne"]
    }

    
    //Timer Func

//    @IBAction func startStop(_ sender: Any) {
//        if (status) {
//            stop()
//            (sender as AnyObject).setTitle("Start", for: .normal)
//            self.resetButton.isEnabled = true
//        }else {
//            start()
//            (sender as AnyObject).setTitle("Stop", for: .normal)
//            self.resetButton.isEnabled = false
//        }
//    }
//
//
//    @IBAction func resetOnTap(_ sender: Any) {
//        timer?.invalidate()
//        startTime = 0
//        time = 0
//        elasped = 0
//        status = false
//
//        let startReset = String("00")
//        minuteLabel.text = startReset
//        secondLabel.text = startReset
//        millisecondLabel.text = startReset
//
//    }
//
//
//    func start() {
//        startTime = Date().timeIntervalSinceReferenceDate - elasped
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//        status = true
//
//    }
//
//    func stop() {
//        elasped = Date().timeIntervalSinceReferenceDate - startTime
//        timer?.invalidate()
//        status = false
//    }
//
//    func updateCounter() {
//        time = Date().timeIntervalSinceReferenceDate - startTime
//        let minutes = UInt8(time / 60.0)
//        time -= (TimeInterval(minutes) * 60)
//        let seconds = UInt8(time)
//        time -= TimeInterval(seconds)
//        let milliseconds = UInt8(time * 100)
//        let startMinutes = String(format: "%02d", minutes)
//        let startSeconds = String(format: "%02d", seconds)
//        let startMilliseconds = String(format: "%02d", milliseconds)
////        minuteLabel.text = startMinutes
////        secondLabel.text = startSeconds
////        millisecondLabel.text = startMilliseconds
//
//
//
//    }
//
//    func displayAlert()
//    {
//        let alert = UIAlertController(title: "Time's Up", message: nil, preferredStyle: .alert)
//        let okButton = UIAlertAction(title: "ok", style: .default, handler: {action in self.status})
//        alert.addAction(okButton)
//
//        present(alert, animated: true, completion: nil)
//    }
//
    
    
    
    // tableview funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let myItem = list[indexPath.row]
//        cell.textLabel?.text = myItem.label
        cell.textLabel?.text = myItem
        if indexPath.row  % 2 == 0 {
            cell.backgroundColor = UIColor.white
        } else if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.gray
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            let destVC = segue.destination as! secondViewController
            let Index = myTable.indexPathForSelectedRow?.row
                
            destVC.activity = list[Index!]
            
        }
    }
    
 

}

