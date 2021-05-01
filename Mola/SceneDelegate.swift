//
//  SceneDelegate.swift
//  Mola
//
//  Created by 김민창 on 2021/04/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        NotificationCenter.default.addObserver(self, selector:#selector(showMainViewController(notification:)),name:LoginVC.NotificationDone,object: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let splashView = SplashVC()
        let nav = UINavigationController(rootViewController: splashView)
        
        window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
//        nav1.tabBarItem.title = "SnapKit"
//        nav1.tabBarItem.image = UIImage(systemName: "house.fill")
//        let vc2 = SnpViewController()
//        let vc3 = ThenViewController()
//        let nav2 = UINavigationController(rootViewController: vc2)
//        let nav3 = UINavigationController(rootViewController: vc3)
//        let tab = UITabBarController()
//        tab.viewControllers = [nav1, nav2, nav3]
//        tab.selectedIndex = 0
//        nav2.tabBarItem.title = "SnapKit"
//        nav2.tabBarItem.image = UIImage(systemName: "house")
//
//        nav3.tabBarItem.title = "Then"
//        nav3.tabBarItem.image = UIImage(systemName: "star")
    }
    
    @objc func showMainViewController(notification: Notification){
        let mainView = MainVC()
        let homeNav = UINavigationController(rootViewController: mainView)
        
        let tab = UITabBarController()
        
        tab.viewControllers = [homeNav]
        tab.selectedIndex = 0
        
        homeNav.tabBarItem.image = UIImage(systemName: "house.fill")
        
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

