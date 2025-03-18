import UIKit

open class LUViewController: UIViewController {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        luInit()
        _luNoti()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        luInit()
        _luNoti()
    }
    
    //MARK: - 重写方法
    deinit {
        print(#function, type(of: self), self)
        luDeinit()
    }
    
    open func luInit() {
        hidesBottomBarWhenPushed = true
    }
    
    open func luDeinit() {
        
    }
    
    final func _luNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(_skinChange), name: NSNotification.Name("NOTIFICATION_SKIN_CHANGE"), object: nil)
    }
    
    @objc private func _skinChange(_ noti:Notification) {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
//MARK: -
    open override var shouldAutorotate: Bool {
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    open func dynamicStatusBarStyle(_ style:UIUserInterfaceStyle) -> UIStatusBarStyle {
        return .darkContent
    }
    
}
