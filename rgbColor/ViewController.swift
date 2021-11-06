//
//  ViewController.swift
//  rgbColor
//
//  Created by Дэлина Дворжецкая on 05.11.2021.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    func setBackgroundColor(redDelegate: Float, greenDelegate: Float, blueDelegate: Float) {
        view.backgroundColor = UIColor(displayP3Red: CGFloat(redDelegate), green: CGFloat(greenDelegate), blue: CGFloat(blueDelegate), alpha: 1)
        red = Double(redDelegate)
        green = Double(greenDelegate)
        blue = Double(blueDelegate)
    }
    
    
    var red = 1.0
    var green = 1.0
    var blue = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettignsViewController else { return }
        settingsVC.red = red
        settingsVC.green = green
        settingsVC.blue = blue
        settingsVC.delegate = self
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        
    }


}


