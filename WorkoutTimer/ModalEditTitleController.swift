//
//  ModalEditTitleController.swift
//  WorkoutTimer
//
//  Created by admin on 04.09.17.
//  Copyright © 2017 Anton Pobigai. All rights reserved.
//

import UIKit

class ModalEditTitleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ok(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        print("Poidyk")
        
        
    }
    

}
