//
//  ViewController.swift
//  UserDefaultsObserve
//
//  Created by Ruvim Miksanskiy on 8/4/18.
//  Copyright © 2018 Ruvim Miksanskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// Vars
    private var countObserver:NSKeyValueObservation?
    
    /// IBOutlet
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
        countObserver = defaults.observe(\.demoCount, options: [.initial, .new]) { [weak self] (defaults, change) in
            guard let weakSelf = self, let count = change.newValue else { return }
            weakSelf.updateLabelCount(count: count)
        }
    }
    
    private func removeObserver() {
        countObserver?.invalidate()
        countObserver = nil
    }
}


// MARK: - Helper methods
extension ViewController {
    private func updateLabelCount(count:Int) {
        countLabel.text = "Count: \(count)".uppercased()
    }
}
