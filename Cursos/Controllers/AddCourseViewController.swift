//
//  AddCourseViewController.swift
//  Cursos
//
//  Created by Lilian on 15/05/21.
//

import UIKit

protocol AddCourseViewControllerDelegate: class {
    func update(course: Course)
}

class AddCourseViewController: UIViewController {

    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBOutlet weak var courseLevelTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: AddCourseViewControllerDelegate?
   
    private var courseNetwork = CourseNetwork() //instancia do curso network
    
    
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
    
    func saveCourse() {
        let course = Course(id: 1, name: courseNameTextField.text, level: courseLevelTextField.text)
        showLoad(true)
        courseNetwork.save(course: course) { (result) in
            DispatchQueue.main.async {
                self.showLoad(false)
                switch result {
                case .success(let response):
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.update(course: response)
                case .failure(let error):
                    print(error)
                }
            }
        
        }
    }
    
    @IBAction func addCourse() {
        if courseNameTextField.text != "" &&
            courseLevelTextField.text != "" {
            saveCourse()
        }else {
            print("Nome do curso e Nível são obrigatórios")
        }
        
        
    }
    
  
}
