//
//  HealthDataViewController.swift
//  Reset
//
//  Created by Raksha on 14/11/24.
//

import UIKit

class HealthDataViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var SexPicker: UIPickerView!
    let genders = ["Male", "Female", "Other"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SexPicker.delegate = self
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
            }
            
            // Number of rows in the picker view (based on genders array)
            func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                return genders.count
            }
            
            // MARK: - UIPickerView Delegate Methods
            
            // Title for each row
            func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                return genders[row]
            }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
