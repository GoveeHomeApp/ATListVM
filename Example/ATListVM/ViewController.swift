//
//  ViewController.swift
//  ATListVM
//
//  Created by yebiaoli on 03/11/2025.
//  Copyright (c) 2025 yebiaoli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickBtn(_ sender: Any) {
        let vctl = Demo1ViewControlelr()
        self.navigationController?.pushViewController(vctl, animated: true)
    }
}

