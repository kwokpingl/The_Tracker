//
//  ViewController.swift
//  The Tracker
//
//  Created by Jimmy on 2018/2/12.
//  Copyright © 2018年 WSJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum ButtonType:Int {
        case Setup = 1
        case History
        case Others
    }
    
    @IBOutlet weak var mapContainerView: UIView!

    @IBOutlet weak var settingContainerView: UIView!
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonsPressed(_ sender: UIButton) {
        
        if let buttonType = ButtonType.init(rawValue: sender.tag) {
            switch buttonType {
            case .Setup :
                settingContainerView.isHidden = !settingContainerView.isHidden
            default:
                return
            }
        }
        
        
    }
    

}

