//
//  ViewController.swift
//  SomaliCardGames
//
//  Created by unitlabs on 12/6/20.
//  Copyright © 2020 sarakhater. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IbOutlet
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    var blueBorderColor = UIColor(red: 27/255, green: 156/255, blue: 244/255, alpha: 1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews();
    }
    
    
    
    func initViews(){
          setButtonBorder(btn1);
          setButtonBorder(btn2);
          setButtonBorder(btn3);
          setButtonBorder(btn4);
          setButtonBorder(btn5);
    }
    
    func setButtonBorder (_ btn : UIButton){
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = blueBorderColor.cgColor;
              
    }
    
    @IBAction func openNextView(_ sender: UIButton) {
        onButtonClicked(sender);
    }
    
    func onButtonClicked(_ sender : UIButton){
        
        
    }


}

