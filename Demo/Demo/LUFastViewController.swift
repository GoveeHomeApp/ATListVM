//
//  LUFastViewController.swift
//  Lib_UI
//
//  Created by abiaoyo on 2024/11/22.
//

import UIKit

open class LUFastViewController: LUViewController {
    
    //MARK: - 重写方法
    open override func luDeinit() {
        super.luDeinit()
        setupDeinit()
    }
    
    open override func luInit() {
        super.luInit()
        setupInit()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupFirst()
        setupData()
        setupSubviews()
        setupLayout()
        setupEvent()
        setupNoti()
        setupLast()
    }
    
    public private(set)  var isFirstViewWillAppear = true
    public private(set)  var isFirstViewDidAppear = true
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if isFirstViewWillAppear {
            isFirstViewWillAppear = false
            viewWillAppearFirst()
        }else{
            viewWillAppearNotFirst()
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstViewDidAppear {
            isFirstViewDidAppear = false
            viewDidAppearFirst()
        }else{
            viewDidAppearNotFirst()
        }
    }
    
    open func setupDeinit() {
        
    }
    
    open func setupInit() {
        
    }
    
    open func setupData() {
        
    }
    
    open func setupSubviews() {
        
    }
    
    open func setupLayout() {

    }
    
    open func setupNoti() {
        
    }
    
    open func setupEvent() {
        
    }
    
    open func setupFirst() {
        
    }
    
    open func setupLast() {
        
    }
    
    open func viewWillAppearFirst() {
        
    }
    
    open func viewDidAppearNotFirst() {
        
    }
    open func viewDidAppearFirst() {
        
    }
    
    open func viewWillAppearNotFirst() {
        
    }
}
