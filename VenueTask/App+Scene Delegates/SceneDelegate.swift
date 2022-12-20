//
//  SceneDelegate.swift
//  VenueTask
//
//  Created by Ibtikar on 14/12/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
 
    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
    let numbers: [[Int]?] = [[10, 20, 42, 3], [10, 20, 42, 3], [10, 20, 42, 3]]
       let flaat = numbers.flatMap { item in
            print("flatMap \(item)")
            return item
        }
     let comm = numbers.compactMap { item in
            print(" compactMap \(item)")
            return item
        }
        print(flaat)
        print(comm)
        
//         let average: Int = numbers.reduce(0, &-)/numbers.count
//         let average1: Int = numbers.reduce(0, &+)/numbers.count
       
//       let numbers: [Int] = [1000, 5670, 42, 21341123, 9_223_372_036_854_775_807]
//        let average: Int = numbers.reduce(0, &-)/numbers.count
//        let average1: Int = numbers.reduce(0, &+)/numbers.count
//
//        print("Result -> \(average1)")
//        print("Result -> \(average)")
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        AppManager.shared.initWindow(window)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        CoreDataStack(modelName: "VenueTask").saveContext()
    }

}
