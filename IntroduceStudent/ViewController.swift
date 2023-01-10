//
//  ViewController.swift
//  IntroduceStudent
//
//  Created by Pei Qi Tea on 10/1/23.
//

import UIKit

class ViewController: UIViewController {
    // Input Controls
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var morePetsStepper: UIStepper!
    @IBOutlet weak var morePetsSwitch: UISwitch!
    
    // Display number of pets
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    
    // The current User instance (initialized with default values)
    var user: User = User(firstName: "", lastName: "", schoolName: "", academicYear: "", numberOfPets: 0, morePets: false)
    
    // A model of the academic years and their
    // indices in the SegmentedControl
    let ACADEMIC_YEAR_INDICES = [
        "First": 0,
        "Second": 1,
        "Third": 2,
        "Fourth": 3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Restore any user data saved previously (if any)
        if let data = UserDefaults.standard.object(forKey: "introducedUser") as? Data,
           let introducedUser = try? JSONDecoder().decode(User.self, from: data) {
            user = introducedUser
            
            yearSegmentedControl.selectedSegmentIndex = ACADEMIC_YEAR_INDICES[user.academicYear] ?? 0
            
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            schoolNameTextField.text = user.schoolName
            numberOfPetsLabel.text = String(user.numberOfPets)
            morePetsSwitch.isOn = user.morePets
        }
        
    }

    @IBAction func stepperDidChange(_ sender: UIStepper) {
        // Update the label
        numberOfPetsLabel.text = "\(Int(sender.value))"
        
    }
    
    
    @IBAction func introduceSelfDidTapped(_ sender: UIButton) {
        // Get the selected academic year
        // and other inputs
        user.academicYear = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex) ?? ""
        
        user.firstName = firstNameTextField.text!
        user.lastName = lastNameTextField.text!
        user.schoolName = schoolNameTextField.text!
        user.numberOfPets = Int(numberOfPetsLabel.text!) ?? 0
        user.morePets = morePetsSwitch.isOn
        
        // Save the modified user object
        // to UserDefaults
        saveUserDetails()
        
        // Create the introduction
        var introduction = "My name is \(user.firstName) \(user.lastName). " +
        "I'm currently a \(user.academicYear.lowercased())-year student at \(user.schoolName). " + "I own \(user.numberOfPets) pet"
        
        if (user.numberOfPets != 1) {
            introduction += "s, "
        } else {
            introduction += ", "
        }
        

        if (user.morePets) {
            introduction += "and I want more pets!"
        } else {
            introduction += "but I do not want more pets."
        }
        
        
        // Create the alert controller to contain our introduction
        let alertController = UIAlertController(
            title: "Hello, world!",
            message: introduction,
            preferredStyle: .alert)
        
        // Create the dismiss action
        let action = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)
        
        // Attach dismiss action to the alert controller
        alertController.addAction(action)
        
        // Display the controller
        present(alertController, animated: true, completion: nil)
    }

    func saveUserDetails() {
        // Store in UserDefaults
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "introducedUser")
        }
    }

}

