//
//  lvlViewController.swift
//  Tiger-Thunder
//
//  Created by John on 04.03.2024.
//

import Foundation
import UIKit
import SnapKit

class lvlViewContoller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = UIImageView()
        background.frame = view.frame
        view.addSubview(background)
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named: "background")
        
        let lvl = UILabel()
        view.addSubview(lvl)
        lvl.numberOfLines = 0
        lvl.font = UIFont(name: "Victoire", size: 60)
        lvl.textColor = .white
        lvl.textAlignment = .center
        lvl.shadowOffset = CGSize(width: 3, height: 3)
        lvl.shadowColor = .magenta
        lvl.text = "Choose\nLEVEL DIFFICULTY"
        lvl.snp.makeConstraints({ make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        let eButton = UIButton(type: .custom)
        eButton.setImage(UIImage(named: "eButton"), for: .normal)
        eButton.imageView?.contentMode = .scaleAspectFit
        eButton.addAction(UIAction() {
            _ in
            let vc = GameViewController()
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        view.addSubview(eButton)
        
        eButton.snp.makeConstraints({ make in
            make.center.equalTo(view)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        let mButton = UIButton(type: .custom)
        mButton.setImage(UIImage(named: "mButton"), for: .normal)
        mButton.imageView?.contentMode = .scaleAspectFit
        mButton.addAction(UIAction() {
            _ in
            let vc = GameViewController2()
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        view.addSubview(mButton)
        
        mButton.snp.makeConstraints({ make in
            make.top.equalTo(eButton.snp.bottom).offset(16)
            make.centerX.equalTo(eButton)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        let hButton = UIButton(type: .custom)
        hButton.setImage(UIImage(named: "hButton"), for: .normal)
        hButton.imageView?.contentMode = .scaleAspectFit
        hButton.addAction(UIAction() {
            _ in
            let vc = GameViewController3()
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        view.addSubview(hButton)
        
        hButton.snp.makeConstraints({ make in
            make.top.equalTo(mButton.snp.bottom).offset(16)
            make.centerX.equalTo(eButton)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints({ make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        })
    }
    
}
