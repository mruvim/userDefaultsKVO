//
//  ViewController.swift
//  UserDefaultsObserve
//
//  Created by Ruvim Miksanskiy on 8/4/18.
//  Copyright © 2018 Ruvim Miksanskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
    }
    
    deinit {
        removeObserver()
    }
}


// MARK: - Actions
extension ViewController {
    @IBAction func increaseCountTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let count = defaults.integer(forKey: UserDefaults.Key.demoCount)
        let updatedCount = count + 1
        defaults.set(updatedCount, forKey: UserDefaults.Key.demoCount)
        defaults.synchronize()
    }
}



// MARK: - Observer
extension ViewController {
    
    private func setupObserver() {
        let defaults = UserDefaults.standard
        defaults.addObserver(self, forKeyPath:UserDefaults.Key.demoCount, options: [.initial, .new], context:nil)
    }
    
    private func removeObserver() {
        let defaults = UserDefaults.standard
        defaults.removeObserver(self, forKeyPath: UserDefaults.Key.demoCount, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        guard keyPath == UserDefaults.Key.demoCount else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if let count = change?[.newKey] as? Int {
            updateLabelCount(count: count)
        }
    }
}


// MARK: - Helper methods
extension ViewController {
    private func updateLabelCount(count:Int) {
        countLabel.text = "Count: \(count)".uppercased()
    }
}
