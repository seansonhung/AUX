//
//  BluetoothController.swift
//  Aux
//
//  Created by Sean Nguyen on 2020-11-09.
//

import UIKit

class BluetoothController: UIViewController {
    
    //go back to main page when tap button
    @IBAction func didTapButton(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "mainStoryboard") as? ViewController else {
            print("failed to get vc from storyboard")
            return
        }
        //This is to full screen the new view, default is not
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        // Do any additional setup after loading the view.
    }
    
    

}
