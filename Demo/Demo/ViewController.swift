//
//  ViewController.swift
//  Demo
//
//  Created by abiaoyo on 2025/3/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickBtn(_ sender: Any) {
        let vctl = Demo1ViewControlelr()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
    @IBAction func clickBtn2(_ sender: Any) {
        let vctl = DiscoveryViewController()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
    

}

