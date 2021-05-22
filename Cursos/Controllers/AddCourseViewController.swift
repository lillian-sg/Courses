//
//  AddCourseViewController.swift
//  Cursos
//
//  Created by Lilian on 15/05/21.
//

import UIKit

class AddCourseViewController: UIViewController {

    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBOutlet weak var courseLevelTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad(false)
      
    }
    
    func showLoad(_ show: Bool) {
        if show {
            addButton.setTitle("", for: .normal)
            activityIndicator.startAnimating()
        }else {
            let titleButton = "ADICIONAR"
            addButton.setTitle(titleButton, for: .normal)
            activityIndicator.stopAnimating()
        }
    
        
    }
    
    @IBAction func addCourse() {
    }
    
  
}
