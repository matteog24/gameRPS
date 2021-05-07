//
//  ViewController.swift
//  gameRPS
//
//  Created by Matteo Garzon on 08/12/2020.
//  Copyright © 2020 Matteo Garzon. All rights reserved.
//

import AVFoundation
import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var cpuImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var buttonRock: UIButton!
    @IBOutlet weak var buttonPaper: UIButton!
    @IBOutlet weak var buttonScissors: UIButton!
    
    @IBOutlet weak var userChoiceSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var cpuPointsLabel: UILabel!
    @IBOutlet weak var playerPointsLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    var difficulty: Int = 0
    var computerChoice: String?
    
    var playerPoints = 0
    var cpuPoints = 0
    
    let hands = ["Rock", "Paper", "Scissors"]
    var userButtonChoice = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateDifficulty(newDifficulty: difficulty);
        
        // Do any additional setup after loading the view.
    }
    
    func updateDifficulty(newDifficulty: Int) {
        
        difficulty = newDifficulty;
        label.text = "Difficulty " + String(difficulty)
        resetPointsLabels()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination;
        
        if (destination is SettingsViewController) {
            let realDestination = destination as! SettingsViewController;
            realDestination.firstViewController = self;
            
        }
    }
    
    
    @IBAction func buttonRock(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.userImageView.alpha = 0
        }
        userImageView.image = UIImage(named: "rock")!
        UIView.animate(withDuration: 0.3) {
            self.userImageView.alpha = 1
        }
        
        userButtonChoice = "Rock"
        game()
    }
    
    @IBAction func buttonPaper(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.userImageView.alpha = 0
        }
        userImageView.image = UIImage(named: "paper")!
        UIView.animate(withDuration: 0.3) {
            self.userImageView.alpha = 1
        }
        
        userButtonChoice = "Paper"
        
        game()
    }
    
    @IBAction func buttonScissors(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.userImageView.alpha = 0
        }
        userImageView.image = UIImage(named: "scissors")!
        UIView.animate(withDuration: 0.3) {
            self.userImageView.alpha = 1
        }
        
        userButtonChoice = "Scissors"
        game()
    }
    
    // if statements
    func game() {
        if difficulty == 0 {
            gameDifficulty0()
        }
        else if difficulty == 1 {
            gameDifficulty1()
        }
        else if difficulty == 2 {
            gameDifficulty2()
        }
        else {
            gameDifficulty3()
        }
        if cpuPoints == 10 {
            label.text = "Computer won! Better luck next time!"
            resetPointsLabels()
        }
        else if playerPoints == 10 {
            label.text = "You won the game! Great!"
            playAudio()
            resetPointsLabels()
        }
    }
    
    // function of games
    func gameDifficulty0() {
        var arrayOfPossibility: [Int]
        if userButtonChoice == hands[0] {
            arrayOfPossibility = [0, 0, 0, 0, 1, 1, 2, 2, 2, 2]
        }
        else if userButtonChoice == hands[1] {
            arrayOfPossibility = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2]
        }
        else {
            arrayOfPossibility = [0, 0, 1, 1, 1, 1, 2, 2, 2, 2]
        }
        
        computerChoice = hands[arrayOfPossibility.randomElement()!]
        
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 0
        }
        
        cpuImageView.image = UIImage(named: String((computerChoice?.lowercased())!))
        
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 1
        }
        
        determineTheWinner()
    }
    
    func gameDifficulty1() {
        computerChoice = hands.randomElement()
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 0
        }
        cpuImageView.image = UIImage(named: String((computerChoice?.lowercased())!))
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 1
        }
        determineTheWinner()
    }
    
    func gameDifficulty2() {
        var arrayOfPossibility: [Int]
        if hands[userChoiceSegmentedControl.selectedSegmentIndex] == hands[0] {
            arrayOfPossibility = [0, 0, 1, 1, 1, 1, 1, 1, 2, 2]
        }
        else if hands[userChoiceSegmentedControl.selectedSegmentIndex] == hands[1] {
            arrayOfPossibility = [0, 0, 1, 1, 2, 2, 2, 2, 2, 2]
        }
        else {
            arrayOfPossibility = [0, 0, 0, 0, 0, 0, 1, 1, 2, 2]
        }
        
        computerChoice = hands[arrayOfPossibility.randomElement()!]
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 0
        }
        cpuImageView.image = UIImage(named: String((computerChoice?.lowercased())!))
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 1
        }
        determineTheWinner()
    }
    
    func gameDifficulty3() {
        // n = index to remove. The one who loses.
        let n: Int!
        if hands[userChoiceSegmentedControl.selectedSegmentIndex] == hands[0] {
          n = 2;
        }
        else if hands[userChoiceSegmentedControl.selectedSegmentIndex] == hands[1] {
          n = 0;
        }
        else {
          n = 1;
        }

        // choosing randomly without n. Computer always wins
        var handsNums = [Int](0...2)
        handsNums.remove(at: n)
        computerChoice = hands[handsNums.randomElement()!]
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 0
        }
        cpuImageView.image = UIImage(named: String((computerChoice?.lowercased())!))
        UIView.animate(withDuration: 0.3) {
            self.cpuImageView.alpha = 1
        }
        
        determineTheWinner()
    }
    
    func determineTheWinner() {
        if userButtonChoice == computerChoice {
            label.text = "Tie!"
        }
        else if userButtonChoice == hands[0] && computerChoice == hands[2] {
            label.text = "You win"
            playerPoints = playerPoints + 1
            updatePlayerPointsLabel()
        }
        else if userButtonChoice == hands[1] && computerChoice == hands[0] {
            label.text = "You win"
            playerPoints = playerPoints + 1
            updatePlayerPointsLabel()
            
        }
        else if userButtonChoice == hands[2] && computerChoice == hands[1] {
            label.text = "You win"
            playerPoints = playerPoints + 1
            updatePlayerPointsLabel()
        }
        else {
            label.text = "Computer wins"
            cpuPoints = cpuPoints + 1
            cpuPointsLabel.text = "CPU points = " + String(cpuPoints)
        }
    }
    
    // update points on player label
    func updatePlayerPointsLabel() {
        playerPointsLabel.text = "Your Points = " + String(playerPoints)
    }
    
    func resetPointsLabels() {
        cpuPoints = 0
        playerPoints = 0
        cpuPointsLabel.text = "CPU points = " + String(cpuPoints)
        playerPointsLabel.text = "Your Points = " + String(playerPoints)
    }
    
    // play audio when winning
    func playAudio() {
        let urlString = Bundle.main.path(forResource: "audio", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch {
            print("Something went wrong")
        }
    }

}
