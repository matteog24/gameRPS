//
//  SettingsViewController.swift
//  gameRPS
//
//  Created by Matteo Garzon on 09/12/2020.
//  Copyright © 2020 Matteo Garzon. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var firstViewController: FirstViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = firstViewController!.difficulty;

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func handleSegmentedControlChanged(_ sender: UISegmentedControl) {
        let difficultyLevel = sender.selectedSegmentIndex;
        firstViewController?.updateDifficulty(newDifficulty: difficultyLevel);
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
