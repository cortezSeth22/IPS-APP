//
//  secondViewController.swift
//  IPS APP
//
//  Created by  on 1/11/18.
//  Copyright © 2018 Dirty Sanchez Apps. All rights reserved.
//

import UIKit
import AVFoundation

class secondViewController: UIViewController {
// var and outlets
    var activity = ""
    var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elasped: Double = 0
    var status: Bool = false
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var millisecondLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var videoView: UIImageView!
 
    lazy var playButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 50, y: 50, width: 75, height: 75)
        button.tintColor = UIColor.black
        button.setImage(#imageLiteral(resourceName: "blackPlayButton"), for: .normal)
        button.addTarget(self, action: #selector(playVideoFile), for: .touchUpInside)
    
        return button
    }()
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.addSubview(playButton)
        playButton.isHidden = false
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        print(activity)
        resetButton.isEnabled = false

        
        if let path = Bundle.main.path(forResource: "videoOne.MOV", ofType: nil){
            let url = URL(fileURLWithPath: path)
            
            videoView.image = getThumbnailFrom(path: url)
        }
      
            }
//buttons
    
    @IBAction func startStop(_ sender: Any) {
        if (status) {
                stop()
                (sender as AnyObject).setTitle("Start", for: .normal)
                self.resetButton.isEnabled = true
                }else {
                start()
                (sender as AnyObject).setTitle("Stop", for: .normal)
                self.resetButton.isEnabled = false
                            }
    }
    
    @IBAction func resetOnTap(_ sender: Any) {
        timer?.invalidate()
                        startTime = 0
                        time = 0
                        elasped = 0
                        status = false
        
                        let startReset = String("00")
                        minuteLabel.text = startReset
                        secondLabel.text = startReset
                        millisecondLabel.text = startReset
    }
    
    // timer funcs
        func start() {
            startTime = Date().timeIntervalSinceReferenceDate - elasped
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                status = true
        
            }
    
            func stop() {
                elasped = Date().timeIntervalSinceReferenceDate - startTime
                timer?.invalidate()
                status = false
            }
    
    @objc func updateCounter() {
            time = Date().timeIntervalSinceReferenceDate - startTime
            let minutes = UInt8(time / 60.0)
            time -= (TimeInterval(minutes) * 60)
            let seconds = UInt8(time)
            time -= TimeInterval(seconds)
            let milliseconds = UInt8(time * 100)
            let startMinutes = String(format: "%02d", minutes)
            let startSeconds = String(format: "%02d", seconds)
            let startMilliseconds = String(format: "%02d", milliseconds)
            minuteLabel.text = startMinutes
            secondLabel.text = startSeconds
            millisecondLabel.text = startMilliseconds
            }
    
            func displayAlert(){
                
                let alert = UIAlertController(title: "Time's Up", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "ok", style: .default, handler: {action in self.status})
                alert.addAction(okButton)
        
                present(alert, animated: true, completion: nil)
            }
    
    @objc func playVideoFile() {
            
            if let path = Bundle.main.path(forResource: "\(activity).MOV", ofType: nil){
                let url = URL(fileURLWithPath: path)
                let avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
                let avPlayerLayer = AVPlayerLayer(player: avPlayer)
                avPlayerLayer.frame = videoView.bounds
                videoView.layer.insertSublayer(avPlayerLayer, at: 0)
               
                NotificationCenter.default.addObserver(self, selector: #selector(playerFinishedPlayingVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer.currentItem)
            avPlayer.play()
            playButton.isHidden = true
                
            } else {
                print("Video file is not found")
        }
    }
    
    
    @objc func playerFinishedPlayingVideo() {
        let path = Bundle.main.path(forResource: "\(activity).MOV", ofType: nil)
        let url = URL(fileURLWithPath: path!)
        let avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        playButton.isHidden = false
        avPlayer.pause()
        avPlayer.seek(to: kCMTimeZero)
        NotificationCenter.default.removeObserver(self)
    
    }
     
    
    func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
        
    }
    
}
