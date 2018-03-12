//
//  AnserDetailsViewController.swift
//  Botakan
//
//  Created by Kamila Kusainova on 04.02.18.
//  Copyright © 2018 kusainovaka. All rights reserved.
//

import UIKit
import EasyPeasy
import AVFoundation


class AnserDetailsViewController: UIViewController {

    var anderParse : AnderJSON?
    var musicState = 1

    var detailsTakpakBG: BackgroundView = {
        let field = BackgroundView()
        field.isUserInteractionEnabled = true
        return field
    }()
    let detailsViewAnder: CollectionViewDetails = {
        let field = CollectionViewDetails()
        field.frame = CGRect(x: screenWidth / 15, y: screenWidth / 1.92, width: screenWidth / 1.153 , height: screenHeight / 1.66)
        field.imageCV.image =  UIImage(named: "an.png")
        field.layer.masksToBounds = false
        field.layer.shadowOffset = CGSize(width: 3, height: 3)
        field.layer.shadowOpacity = 0.3
        field.layer.cornerRadius = 10
        field.layer.shadowRadius = 1
        field.layer.shadowColor = UIColor.black.cgColor
        field.backgroundColor = .white
        return field
    }()
    public lazy var musicVC: MusicView = {
        let music = MusicView()
        music.backgroundColor = .bgMusic
        music.layer.masksToBounds = false
        music.layer.shadowOffset = CGSize(width: 3, height: 3)
        music.layer.shadowOpacity = 0.3
        music.layer.shadowRadius = 1
        music.layer.borderWidth = 2
        music.layer.borderColor = UIColor.white.cgColor
        music.layer.cornerRadius = 5
        return music
    }()
    public lazy var nameAnder: UILabel = {
        let takpakLB = UILabel()
        takpakLB.textColor = .BlueColor
        takpakLB.textAlignment = .center
        takpakLB.font = UIFont(name: "Noteworthy-Bold", size: screenWidth / 18.75)
        return takpakLB
    }()
    public lazy var ander: UITextView = {
        let takpakLB = UITextView(frame: CGRect(x: screenWidth / 6, y: screenWidth / 3.5, width: screenWidth / 1.563, height: screenWidth / 1.3))
        takpakLB.textAlignment = NSTextAlignment.justified
        takpakLB.showsVerticalScrollIndicator = false
        takpakLB.isScrollEnabled = true
        takpakLB.isEditable = false
        takpakLB.textColor = .BlueColor
        takpakLB.font = UIFont(name: "Noteworthy-Light", size: screenWidth / 18.75)
        return takpakLB
    }()
//smt
    var audioPlayer = AVAudioPlayer()
    var allDurM = Float()
    var nowDurM = Float()
    var a = String()
    var b = String()
  
    var time = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsTakpakBG)
        view.addSubview(detailsViewAnder)
        view.addSubview(musicVC)
        detailsViewAnder.addSubview(nameAnder)
        detailsViewAnder.addSubview(ander)        
        detailsTakpakBG.backBTN.addTarget(self, action: #selector(backToCV), for: .touchUpInside)
        setUpLayout()
        musicConfig()
        ander.text = anderParse?.text
        nameAnder.text = anderParse?.name
        musicVC.imageAnder.image = UIImage(named: (anderParse?.photo)!)
        musicVC.nameAn.text = anderParse?.Anname
        musicVC.nameArtist.text = anderParse?.author
       
        
//        let path = Bundle.main.path(forResource: "\(anderParse?.music)", ofType: "mp3")
//        if let path = path {
//            let mp3URL = NSURL.fileURL(withPath: path)
        do{
//            audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
//            audioPlayer.play()
            let url = Bundle.main.url(forResource: "\(String(describing: anderParse!.music))", withExtension: "mp3")
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
            musicVC.sliderMusic.setProgress(Float(audioPlayer.currentTime / audioPlayer.duration), animated: false)

        }catch let error as NSError {
            print(error.localizedDescription)
        }
//        }
   
        
        let allT = audioPlayer.duration
//        let minutes = Float(allT / 60)
//        let seconds = Float(allT.truncatingRemainder(dividingBy: 60))
//        NSString(format:"%02d:%02d", minutes, seconds) as String
//        nowDurM = Float((allT.truncatingRemainder(dividingBy: 3600)) / 60)
//        b = (String(format: "%.2f", nowDurM))
//        let minutes = allT / 60.truncatingRemainder(dividingBy: 60)
//        let seconds = allT.truncatingRemainder(dividingBy: 60)
//        b = (String(format: "%0.2d:%0.2d", minutes,seconds))
        
//        let seconds = 131.531   // 131.531
        let time = allT.minuteSecondMS  //  "2:11.531"
        let millisecond = allT.millisecond    // 531
        
//        let ms = 1111
//        let sec = ms.msToSeconds.minuteSecondMS
        b = (String(time))
        musicVC.allDurationMusic.text = b
        musicVC.durationMusic.text = "0.00"
     
        
    }
   
    @objc func backToCV(){
        navigationController?.popViewController(animated: false)
    }
    
    @objc func updateProgress(){
        
        if audioPlayer.isPlaying == true{
            musicVC.sliderMusic.setProgress(Float(audioPlayer.currentTime / audioPlayer.duration), animated: true)
                    time = audioPlayer.currentTime
                    allDurM = Float(time / 60)
                    b = (String(format: "%.2f", allDurM))
                    musicVC.durationMusic.text = b
        }
    }
    
    func musicConfig(){
        musicVC.btnMusic.setImage(UIImage(named:"play.png"),for:.normal)
        musicVC.btnMusic.addTarget(self, action: #selector(pressMussic), for: .touchDown)
        musicVC.leftMusic.addTarget(self, action: #selector(leftBTN), for: .touchUpInside)
        musicVC.rightMusic.addTarget(self, action: #selector(rightBTN), for: .touchUpInside)
    }
    
    @objc func pressMussic(){
        if musicState == 1 {
            musicVC.btnMusic.setImage(UIImage(named:"pause.png"),for:.normal)
            audioPlayer.play()
            musicState = 2
        } else {
            musicVC.btnMusic.setImage(UIImage(named:"play.png"),for:.normal)
            audioPlayer.pause()
            musicState = 1
        }
    }
    @objc func leftBTN(){
        
    }
    @objc func rightBTN(){
        
    }
    @objc func scrollMusic(){
        AudioPlayer.stop()
        AudioPlayer.currentTime = TimeInterval(sliderMusic.value)
        AudioPlayer.prepareToPlay()
        musicState = 1
        AudioPlayer.play()
    }
    
    func setUpLayout(){
        detailsTakpakBG <- [
            Top(0),
            Width(screenWidth),
            Left(0),
            Height(screenHeight)
        ]
        musicVC <- [
            Top(screenWidth / 3.75),
            Width(screenWidth / 1.1538),
            Left(screenWidth / 15),
            Height(screenWidth / 4.166)
        ]
        nameAnder <- [
            CenterX(0),
            Top(screenWidth / 25),
            Width(screenWidth / 1.5),
            Height(screenWidth / 11.72)
        ]
    }
}


extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
