//
//  CardViewController.swift
//  SomaliCardGames
//
//  Created by unitlabs on 12/6/20.
//  Copyright © 2020 sarakhater. All rights reserved.
//

import UIKit
import AVFoundation


class CardViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var   wordLabel : UILabel!
    @IBOutlet weak var   gifImage : UIImageView!
    @IBOutlet weak var correctCountLabel: UILabel!
    @IBOutlet weak var wrongCountLabel: UILabel!
    @IBOutlet weak var correctView: UIView!
    @IBOutlet weak var wrongView: UIView!
    //MARK:- Variables
    var currentSection = 1;
    var m_wordsList  : [String] = [];
    var m_btnList  : [UIButton] = [];
    var m_correctBtn = 0;
    var m_QNO = 0;
    var m_lasNo: Set<Int> = Set();
    var correctCount = 0;
    var wrongCount = 0;
    var selectedRandomSET: Set<Int> = Set()


    
    var player: AVAudioPlayer?
    let blueBorderColor = UIColor(red: 27/255, green: 156/255, blue: 244/255, alpha: 1.0);
    //let blackBorderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0);
    let greenBorderColor = UIColor(red: 73/255, green: 255/255, blue: 81/255, alpha: 1.0);
    let redBorderColor = UIColor(red: 254/255, green: 1/255, blue: 56/255, alpha: 1.0);
    
    let attrString = NSAttributedString(
        string: "Fool",
        attributes: [
            NSAttributedString.Key.strokeColor: UIColor.white,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -2.0,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //wordLabel.attributedText = attrString;
        
        //1- AddButtonTo List
        m_btnList.append(btn1);
        m_btnList.append(btn2);
        m_btnList.append(btn3);
        
        //2- Read text file with parsing tag
        ReadWords(filePath : "\(currentSection)text");
        
        //3- get next word
        getNextQuestion();
        gifImage.isHidden = true;
        setCountLabelBorder();
        
    }
    func setCountLabelBorder(){
        correctView.layer.borderColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1.0).cgColor
        correctView.layer.borderWidth = 2;
        correctView.layer.cornerRadius = 8;
        wrongView.layer.borderColor = UIColor(red: 191/255, green: 21/255, blue: 20/255, alpha: 1.0).cgColor
        wrongView.layer.borderWidth = 2;
        wrongView.layer.cornerRadius = 8;
        wrongView.isHidden = true;   
    }
    
    @IBAction func goHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
    func setButtonBorder (_ btn : UIButton){
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 2;
        btn.layer.masksToBounds = true;
        btn.layer.borderColor = blueBorderColor.cgColor;
        
    }
    
    func ReadWords(filePath : String ){
        if let path = Bundle.main.path(forResource: filePath , ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                var stringWithSeperator = myStrings.joined(separator: ",")
                m_wordsList = stringWithSeperator.components(separatedBy: ",,");
                for (index , item) in m_wordsList.enumerated(){
                    if(item.isEmpty){
                        m_wordsList.remove(at: index);
                    }
                }
                //m_lasNo  = Set(repeating: 0, count: 20);
                
                m_lasNo = Set([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]);
                //m_wordsList.count - 1);
            } catch {
                print(error)
            }
        }
    }
    
    func playSound(soundFileName : String , soundExtension : String ) {
        guard
            let url = Bundle.main.url(forResource: soundFileName , withExtension: soundExtension) else { return };
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true);
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue);
            guard let player = player else { return }
            player.play();
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getRndName() -> Int{
        
        let x = Int.random(in: 0 ... m_wordsList.count - 1);
        if(  isAvailable(i: x)){
            if(!selectedRandomSET.contains(x)){
                if(selectedRandomSET.count == 3){
                    selectedRandomSET = Set()
                }
                selectedRandomSET.insert(x)
                  return x;
            }else{
                 return getRndName();
            }
          
        }
        else {
            return getRndName();
        }
    }
    
    func isAvailable(i : Int)  -> Bool {
         m_lasNo.insert(i);
        //print("position", "m_lasNo>>>\(m_lasNo)") ;
        m_lasNo.remove(11);
        return true;

    }
    
    func getNextQuestion(){
          setButtonBorder(btn1);
          setButtonBorder(btn2);
          setButtonBorder(btn3);
           m_QNO = 0;
        
        //1- sleep for 300 millisecond
        
        let second: Double = 1000000
        usleep(useconds_t(0.3 * second));
        
        //2- get random number
        m_correctBtn  = Int.random(in: 0...2);
        
        var  i = 0;
        
        for btn in m_btnList{
            let  x = getRndName();
            if(m_correctBtn == i){
                m_QNO = x;
                print(m_QNO);
            }
            print("\(currentSection)p\(x)");
            print("image name====> \(currentSection)p\(x).jpg")
            btn.setBackgroundImage(UIImage(named: "\(currentSection)p\(x).jpg"), for: .normal);
            setButtonBorder(btn);
            i += 1;
        }
        
        //3- play sound with this word
        
        playSound(soundFileName: "\(currentSection)s\(m_QNO)"  , soundExtension : "mp3");
        
        // 4- enable Button clicked
        
        btn1.isUserInteractionEnabled = true;
        btn2.isUserInteractionEnabled = true ;
        btn3.isUserInteractionEnabled = true;
         print(m_QNO);
        wordLabel.text = m_wordsList[m_QNO];
        
    }
    
    func  getnextQuestion0() {
        
        btn1.isUserInteractionEnabled = false;
        btn2.isUserInteractionEnabled = false ;
        btn3.isUserInteractionEnabled = false;
        do {
            playSound( soundFileName: "cheering1" , soundExtension : "wav");
            gifImage.image = UIImage(named: "gt1");
            gifImage.isHidden = false;
            gifImage.alpha = 1;

            LongOperation();
            
        }
    }
    
    func LongOperation(){
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.gifImage.alpha = 0;
            self.gifImage.isHidden = true
            self.getNextQuestion();
        }
       
    }
    
    @IBAction func onButtonsClicked(_ sender: UIButton) {
        if (sender.tag == 1) {
            if (m_correctBtn == 0) {
                getnextQuestion0();

                sender.layer.borderColor = greenBorderColor.cgColor;
                UIView.animate(withDuration: 0.6,
                animations: {
                   sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                },
                completion: { _ in
                    UIView.animate(withDuration: 0.6) {
                        sender.transform = CGAffineTransform.identity
                    }
                })
                correctCount += 1;
                if(wrongCount == 0){ }else{  wrongCount -= 1}


            }
            else {
                sender.layer.borderColor = redBorderColor.cgColor;
                playSound(soundFileName: "x", soundExtension: "mp3");
                wrongCount += 1
            }
        } else if (sender.tag == 2) {
            if (m_correctBtn == 1) {
                

                getnextQuestion0();
                sender.layer.borderColor = greenBorderColor.cgColor;
                UIView.animate(withDuration: 0.6,
                               animations: {
                                  sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                               },
                               completion: { _ in
                                   UIView.animate(withDuration: 0.6) {
                                       sender.transform = CGAffineTransform.identity
                                   }
                               })
                correctCount += 1;
                if(wrongCount == 0){ }else{  wrongCount -= 1}


            }
            else {
                sender.layer.borderColor = redBorderColor.cgColor;
                playSound(soundFileName: "x", soundExtension: "mp3");
               wrongCount += 1


            }
        } else if (sender.tag == 3) {
            if (m_correctBtn == 2){
                getnextQuestion0();

                sender.layer.borderColor = greenBorderColor.cgColor;
                UIView.animate(withDuration: 0.6,
                               animations: {
                                  sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                               },
                               completion: { _ in
                                   UIView.animate(withDuration: 0.6) {
                                       sender.transform = CGAffineTransform.identity
                                   }
                               })
                  correctCount += 1;
                if(wrongCount == 0){ }else{  wrongCount -= 1}

            }
            else {
                sender.layer.borderColor = redBorderColor.cgColor;
                playSound(soundFileName: "x", soundExtension: "mp3");
                wrongCount += 1
                

            }
        }
        correctCountLabel.text = "\(correctCount)";
        wrongCountLabel.text = "\(wrongCount)";

    }
    
    
    
    @IBAction func playAudio(_ sender: UIButton) {
       
       playSound(soundFileName: "\(currentSection)s\(m_QNO)", soundExtension: "mp3")
    }
    
}

//
//func isAvailable(i : Int)-> Bool {
//
//       print("position", "m_lasNo>>>\(m_lasNo)") ;
//       do {
//           //if(m_lasNo.count > 11)
//          // {
//             try m_lasNo.remove(at: 11);
//          // }
//
//       }catch {
//           print("error canot remove it");}
//       do{
//           if( m_lasNo.count-1  >= i)
//
//
//           { if( try m_lasNo[i] == 0)
//           {
//               if(m_lasNo.contains(i)){
//                     return  false;
//               }else{
//                   m_lasNo.append(i);
//                   return true;
//               }
//
//           }
//           else{
//               return  false;
//           }
//           }else {
//               return false;
//           }
//       }catch let error {
//           print(error.localizedDescription)
//       }
//
//   }
