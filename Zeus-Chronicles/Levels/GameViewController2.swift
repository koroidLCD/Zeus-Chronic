//
//  GameViewController.swift
//  Zeus-Chronicles
//
//  Created by John on 06.03.2024.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController2: UIViewController, SKSceneDelegate, gameDelegate {
    
    var scoreLabel: UILabel!
    
    let skView = SKView()
    
    var score = 0 {
        didSet {
            print(score)
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(skView)
        skView.frame = view.frame
        skView.ignoresSiblingOrder = true
        var scene: GameScene2!
        scene = GameScene2()
        (scene).gameDelegate = self
        scene.scaleMode = .aspectFit
        scene.delegate = self
        skView.presentScene(scene)
        
        scoreLabel = UILabel()
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont(name: "Victoire", size: 30)
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ])
        
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
