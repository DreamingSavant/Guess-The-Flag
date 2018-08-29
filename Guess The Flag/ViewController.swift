//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Roderick Presswod on 4/2/18.
//  Copyright © 2018 Roderick Presswod. All rights reserved.
//

import GameplayKit
import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var showScore: UILabel!
    
    
    var countries : [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us" ]
    
    var correctAnswer = 0
    
    var score = 0
    
    var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game", style: .done, target: self, action: #selector(startOver))
        
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
       
        // can change to custom colors like this : UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor edit numbers to change colors alpha is transparency
        
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        
        countries = GKARC4RandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correct"
            points = 1
            score += points
            
            let ac = UIAlertController(title: title, message: "Correct! Your score increased by \(points) point to give you a score of \(score) points!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Keep Going!", style: .default, handler: askQuestion))
            present(ac, animated: true)
            
        } else {
            title = "Wrong Answer!"
            points = 1
            score -= points
            
            let ac = UIAlertController(title: title, message: "Wrong! Your score decreased by \(points) point. Your score is \(score)!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        showScore.text = "SCORE: \(score)"
        
       /* let ac = UIAlertController(title: title, message: "Correct! Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true) */
    }
    
    // Mark: Add new game button
    
    func newGame(action: UIAlertAction!) {
    
    score = 0
    showScore.text = "SCORE: \(score)"
    askQuestion(action: nil)
//    let ac = UIAlertController(title: "Are you sure?", message: "Are you sure you want to create a new game? Changes cannot be reversed.", preferredStyle: .alert)
//    ac.addAction(UIAlertAction(title: "Restart Game", style: .destructive, handler: askQuestion))
//
//
//    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//    present(ac, animated: true)
    
    
    }
    
    @objc func startOver() {
        
        let ac = UIAlertController(title: "Are you sure?", message: "Are you sure you want to create a new game? Changes cannot be reversed.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Restart Game", style: .destructive, handler: newGame))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
        
    }
    
    // Mark: Add about page
    
    
    //Implement Highest Streak label
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

