//
//  CursoTableViewCell.swift
//  Cursos
//
//  Created by Lilian on 08/05/21.
//

import UIKit

class CursoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCurso: UILabel!
    
    @IBOutlet weak var levelCurso: UILabel!
   
    func configureCell(title: String, level: String){
        titleCurso.text = title
        levelCurso.text = level
    }
        
}


