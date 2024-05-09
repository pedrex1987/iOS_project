//
//  UIViewController+Context.swift
//  project
//
//  Created by Pedro Henrique on 08/05/24.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
