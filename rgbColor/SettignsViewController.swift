//
//  SettignsViewController.swift
//  rgbColor
//
//  Created by Дэлина Дворжецкая on 05.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setBackgroundColor(redDelegate: Float, greenDelegate: Float, blueDelegate: Float)
}

class SettignsViewController: UIViewController {
    
    var delegate: SettingsViewControllerDelegate?
    
    var red = 0.0
    var green = 0.0
    var blue = 0.0

    @IBOutlet var viewSettings: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDoneButtonOnKeyboard()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        viewSettings.layer.cornerRadius = 40
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redTextField.placeholder = String(red)
        greenTextField.placeholder = String(green)
        blueTextField.placeholder = String(blue)
        
        updateColor()
        updateLabels()
        updatePlaceholders()
        
    }
    
    @IBAction func doneButtonPressed() {
        let redDelegate = redSlider.value
        let greenDelegate = greenSlider.value
        let blueDelegate = blueSlider.value
        
        delegate?.setBackgroundColor(redDelegate: redDelegate, greenDelegate: greenDelegate, blueDelegate: blueDelegate)
    }
    
    @IBAction func enteredSlider(_ sender: UISlider) {
        viewSettings.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        
        updateLabels()
        updatePlaceholders()
    }
    
    private func updateColor() {
        view.endEditing(true)
        viewSettings.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    private func updateLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func updatePlaceholders() {
        redTextField.placeholder = String(format: "%.2f", redSlider.value)
        greenTextField.placeholder = String(format: "%.2f", greenSlider.value)
        blueTextField.placeholder = String(format: "%.2f", blueSlider.value)
    }

}

//showAlert(title: "Некорректное значение", message: "Введите число в диаппазоне [0...1]", tag:)

extension SettignsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        if (Double(newValue) ?? 0 > 1 || Double(newValue) ?? 0 < 0) {
            switch textField.tag {
            case 0:
                showAlert(title: "Некорректное значение", message: "Введите число в диаппазоне [0...1]", tag: 0)
            case 1:
                showAlert(title: "Некорректное значение", message: "Введите число в диаппазоне [0...1]", tag: 1)
            default:
                showAlert(title: "Некорректное значение", message: "Введите число в диаппазоне [0...1]", tag: 2)
            }
        } else {
            switch textField.tag {
            case 0:
                redSlider.value = Float(newValue) ?? redSlider.value
                redLabel.text = newValue
            case 1:
                greenSlider.value = Float(newValue) ?? greenSlider.value
                greenLabel.text = newValue
            default:
                blueSlider.value = Float(newValue) ?? blueSlider.value
                blueLabel.text = newValue
            }
        }
        
        updateColor()
        updateLabels()
        updatePlaceholders()
    }
}

extension SettignsViewController {
    func showAlert(title: String, message: String, tag: Int) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            switch tag {
            case 0:
                self.redSlider.value = 0
                self.redTextField.text = ""
                self.updateColor()
                self.updateLabels()
                self.updatePlaceholders()
            case 1:
                self.greenSlider.value = 0
                self.redTextField.text = ""
                self.updateColor()
                self.updateLabels()
                self.updatePlaceholders()
            default:
                self.blueSlider.value = 0
                self.redTextField.text = ""
                self.updateColor()
                self.updateLabels()
                self.updatePlaceholders()
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettignsViewController {
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            redTextField.inputAccessoryView = doneToolbar
            greenTextField.inputAccessoryView = doneToolbar
            blueTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            redTextField.resignFirstResponder()
            greenTextField.resignFirstResponder()
            blueTextField.resignFirstResponder()
        }
}

extension SettignsViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
