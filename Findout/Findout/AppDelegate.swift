//
//  AppDelegate.swift
//  Findout
//
//  Created by Ramzy Kermad on 19/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: LoginScreenViewController())
        window.makeKeyAndVisible()
        self.window = window
        
        // Set the Google Place API's autocomplete UI control
        GMSPlacesClient.provideAPIKey("AIzaSyD9tn2oWwV9zbWHSpyZpy8OlsEhuecwJ40")
        
        // Customize the UI of GMSAutocompleteViewController
        // Set some colors (colorLiteral is convenient)
        let barColor: UIColor = #colorLiteral(red: 0.2193810642, green: 0.7583789825, blue: 0.4023743272, alpha: 1)
        let backgroundColor: UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let textColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        // Navigation bar background.
        UINavigationBar.appearance().barTintColor = barColor
        UINavigationBar.appearance().tintColor = UIColor.white
        // Color and font of typed text in the search bar.
        let searchBarTextAttributes = [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 16)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes as [NSAttributedString.Key : Any]
        // Color of the placeholder text in the search bar prior to text entry
        let placeholderAttributes = [NSAttributedString.Key.foregroundColor: backgroundColor, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)]
        // Color of the default search text.
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes as [NSAttributedString.Key : Any])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attributedPlaceholder
        
        return true
    }


}

