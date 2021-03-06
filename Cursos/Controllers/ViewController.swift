//
//  ViewController.swift
//  Cursos
//
//  Created by Lilian on 08/05/21.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
   private var courseNetwork = CourseNetwork()
   private var courses: [Course] = []
    
    let cursoCellNameAndIdentifier = "CursoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        courseNetwork.getCourses { [weak self] (result) in
           guard let self = self else { return }
            switch result {
            case .success(let courses):
                self.courses = courses
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    
        
    }
    
    func setupTableView() {
        let cursoCellNib = UINib(nibName: cursoCellNameAndIdentifier, bundle: nil)
        tableView.register(cursoCellNib, forCellReuseIdentifier: cursoCellNameAndIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addCourse(_ sender: Any) {
        self.performSegue(withIdentifier: "addCourse", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addCourseVC = segue.destination as? AddCourseViewController {
            addCourseVC.delegate = self
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //esse metodo dequeueReusableCell retorna a celula de acordo com o identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cursoCellNameAndIdentifier, for: indexPath) as? CursoTableViewCell else {
            return UITableViewCell()
        }
        let course = courses[indexPath.row]
        cell.configureCell(title: course.name ?? "n??o informado", level: course.level ?? "n??o informado")
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        let image = UIImage(named: "CAPA")
        let imageViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        let imageView = UIImageView(frame: imageViewFrame)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Deletar") { (action, view, boolValue) in
            print("delete")
        }
        let edit = UIContextualAction(style: .normal, title: "Editar") { (action, view, boolValue) in
            
            print("editando")
            print(self.courses[indexPath.row])
            print(indexPath.row)
            
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        return configuration
    }
  
    
}

extension ViewController: AddCourseViewControllerDelegate {
    func update(course: Course) {
        courses += [course]
        tableView.reloadData()
        let row = courses.count - 1
        let section = tableView.numberOfSections - 1
        let indexPath = IndexPath(row: row, section: section)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}
