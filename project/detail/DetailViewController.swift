//
//  DetailViewController.swift
//  project
//
//  Created by Pedro Henrique on 07/05/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelHour: UILabel!
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var labelLocal: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var problem: ProblemModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EditViewController {
            controller.problem = problem
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    func prepareScreen() {
        if let problem = problem {
            labelHour.text = problem.date?.formatted()
            tfName.text = problem.name
            labelLocal.text = problem.local
            labelDescription.text = problem.descriptionProblem
            if let image = problem.photo {
                imageView.image = UIImage(data: image)
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
            }
        }
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
