//
//  ViewController.swift
//  Swipe Button
//
//  Created by Jobin on 18/04/20.
//  Copyright © 2020 Jobin_Johny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SlideButtonDelegate {
    
    func buttonStatus(status: String, sender: PanicSlidingButton) {
        let alertController = UIAlertController(title: "Action", message: "Done", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBOutlet weak var slideButton: PanicSlidingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideButton.delegate = self
    }
}

