//
//  AppDelegate.swift
//  Demo
//
//  Created by abiaoyo on 2025/3/12.
//

import UIKit
// MARK: - Properties
public extension UIColor {
    
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// SwifterSwift: Random color.
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return UIColor(red: red, green: green, blue: blue)!
    }
}

public class Geometry {
    
    static var screenRate: CGFloat {
        return min(screenWidth, screenHeight) / 375.0
    }
    
    static var maxScreenRate: CGFloat {
        return max(screenRate, 1.0)
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
}

public extension CGFloat {
    var rate: CGFloat { self * Geometry.screenRate }
    
    func roundTo(places:Int) -> CGFloat {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
}

public extension Double {
    var rate: CGFloat { CGFloat(self) * Geometry.screenRate }
    
    /// Rounds the double to decimal places value
    
    func roundTo(places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

