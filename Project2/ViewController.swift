//
//  ViewController.swift
//  Project2
//
//  Created by Amrah on 07.05.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var HighestScore: UITextField!


    var countries = [String]()
    var scores = 0
    var correctAnswer = 0
    var questionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia","france","germany","ireland", "italy", "monaco","nigeria","poland","russia","spain","uk", "us"]
        askQuestions()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        
        //in navigation bar I'm making share button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
    }
    
    
    //left icon
    @objc func showScore() {
        let scoreAlert = UIAlertController(title: "SCORE", message: nil, preferredStyle: .actionSheet)
        scoreAlert.addAction (UIAlertAction (title: "Your current score is \(scores)!", style:.default, handler: nil))
        present (scoreAlert, animated: true)
    }
    @objc func restartGame() {
        restart()
    }
    
    
    func askQuestions(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //we don't want ugly country names
        //title = "Score is:\(scores) -- Find \(countries[correctAnswer].uppercased())'s flag"
        title = countries[correctAnswer].uppercased()
        questionCount += 1
    }
    func restart(action: UIAlertAction! = nil){
        scores = 0
        questionCount = 0
        askQuestions()
    }
        
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer{
            title = "Correct"
            scores += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            scores -= 1
        }
        //Alert
        if questionCount < 10 {
            let ac = UIAlertController(title: title, message:"Your score is \(scores)", preferredStyle:.alert)
            
            ac.addAction(UIAlertAction (title: "Continue", style: .default, handler: askQuestions))
            
            present (ac, animated: true)
        } else{
            if(scores <= 8){
                let finalAlertController1 = UIAlertController(title: "Game over!", message: "Your score is \(scores).", preferredStyle: .alert)
                finalAlertController1.addAction(UIAlertAction(title: "Start new game!", style: .default, handler: restart))
                present(finalAlertController1, animated: true)
            }else {
                let finalAlertController2 = UIAlertController(title: "You Win", message: "Your score is \(scores).", preferredStyle: .alert)
                finalAlertController2.addAction(UIAlertAction(title: "Start new game!", style: .default, handler: restart))
                present(finalAlertController2, animated: true)

            }
        }
        
    }
}
    
