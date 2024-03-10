import UIKit
import SnapKit

class OlympicGameVC: UIViewController {
    
    var selected = -1
    
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!
    let box = UIImageView()
    
    var playButton: UIButton!
    
    var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = UIImageView()
        background.frame = view.frame
        view.addSubview(background)
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named: "background")
        
        let logo = UIImageView()
        view.addSubview(logo)
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named: "logo_2")
        logo.snp.makeConstraints({ make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        view.addSubview(box)
        box.contentMode = .scaleAspectFit
        box.image = UIImage(named: "btn_1")
        
        playButton = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "btn_1"), for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.addAction(UIAction() {
            _ in
            
            if self.selected != -1 {
                var win: res = .loose
                let userChoose = self.selected
                let botChoose = Int.random(in: 1...4)
            
                if userChoose == botChoose - 1  {
                    win = .win
                }
                if userChoose == 4 && botChoose == 1  {
                    win = .win
                }
                if userChoose == 3 && botChoose == 1  {
                    win = .win
                }
                if userChoose == 2 && botChoose == 4  {
                    win = .win
                }
                if userChoose == botChoose {
                    win = .draw
                }
                
                
                let vv = VersusView()
                vv.tag = 2
                
                switch userChoose {
                case 1:
                    vv.firstImageView.image = UIImage(named: "gool_1")
                case 2:
                    vv.firstImageView.image = UIImage(named: "gool_2")
                case 3:
                    vv.firstImageView.image = UIImage(named: "gool_3")
                case 4:
                    vv.firstImageView.image = UIImage(named: "gool_4")
                default:
                    break
                }
                
                switch botChoose {
                case 1:
                    vv.secondImageView.image = UIImage(named: "gool_1")
                case 2:
                    vv.secondImageView.image = UIImage(named: "gool_2")
                case 3:
                    vv.secondImageView.image = UIImage(named: "gool_3")
                case 4:
                    vv.secondImageView.image = UIImage(named: "gool_4")
                default:
                    break
                }
                
                if win == .win {
                    vv.bottomImageView.image = UIImage(named: "win")
                    LightningManager.shared.addOlympPoints(1)
                } else if win == .loose {
                    vv.bottomImageView.image = UIImage(named: "lose")
                } else {
                    vv.bottomImageView.image = UIImage(named: "draw")
                }
                
                vv.translatesAutoresizingMaskIntoConstraints = false
                vv.isHidden = true
                UIView.transition(with: vv, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    vv.isHidden = false
                    self.button1.isHidden = true
                    self.button2.isHidden = true
                    self.button3.isHidden = true
                    self.button4.isHidden = true
                    self.playButton.isHidden = true
                    self.box.isHidden = true
                }, completion: nil)
                
                self.view.addSubview(vv)
                
                NSLayoutConstraint.activate([
                    vv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    vv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    vv.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
                    vv.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
                ])
                
            }
        }, for: .touchUpInside)
        view.addSubview(playButton)
        
        playButton.snp.makeConstraints({ make in
            make.top.equalTo(logo.snp.bottom).offset(15)
            make.centerX.equalTo(view)
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
        })
        
        
        button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "gool_1"), for: .normal)
        button1.imageView?.contentMode = .scaleAspectFit
        button1.addAction(UIAction() {
            _ in
            self.selected = 1
            UIView.transition(with: self.playButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.playButton.setImage(UIImage(named: "gool_1"), for: .normal)
            }, completion: nil)
        }, for: .touchUpInside)
        view.addSubview(button1)
        
        button1.snp.makeConstraints({ make in
            make.right.equalTo(view.snp.centerX)
            make.centerY.equalTo(view).offset(60)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        })
        
        button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "gool_2"), for: .normal)
        button2.imageView?.contentMode = .scaleAspectFit
        button2.addAction(UIAction() {
            _ in
            self.selected = 2
            UIView.transition(with: self.playButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.playButton.setImage(UIImage(named: "gool_2"), for: .normal)
            }, completion: nil)
        }, for: .touchUpInside)
        view.addSubview(button2)
        
        button2.snp.makeConstraints({ make in
            make.left.equalTo(view.snp.centerX)
            make.centerY.equalTo(view).offset(60)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        })
        
        button3 = UIButton(type: .custom)
        button3.setImage(UIImage(named: "gool_3"), for: .normal)
        button3.imageView?.contentMode = .scaleAspectFit
        button3.addAction(UIAction() {
            _ in
            self.selected = 3
            UIView.transition(with: self.playButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.playButton.setImage(UIImage(named: "gool_3"), for: .normal)
            }, completion: nil)
        }, for: .touchUpInside)
        view.addSubview(button3)
        
        button3.snp.makeConstraints({ make in
            make.left.equalTo(view.snp.centerX)
            make.top.equalTo(button1.snp.bottom)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        })
        
        button4 = UIButton(type: .custom)
        button4.setImage(UIImage(named: "gool_4"), for: .normal)
        button4.imageView?.contentMode = .scaleAspectFit
        button4.addAction(UIAction() {
            _ in
            self.selected = 4
            UIView.transition(with: self.playButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.playButton.setImage(UIImage(named: "gool_4"), for: .normal)
            }, completion: nil)
        }, for: .touchUpInside)
        view.addSubview(button4)
        
        button4.snp.makeConstraints({ make in
            make.right.equalTo(view.snp.centerX)
            make.top.equalTo(button1.snp.bottom)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        })
        
        box.snp.makeConstraints({ make in
            make.top.equalTo(button1).offset(-15)
            make.bottom.equalTo(button4).offset(15)
            make.left.equalTo(button4).offset(-15)
            make.right.equalTo(button3).offset(15)
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
        
        let infoButton = UIButton(type: .custom)
        infoButton.setImage(UIImage(named: "btn_info"), for: .normal)
        infoButton.imageView?.contentMode = .scaleAspectFit
        infoButton.addAction(UIAction() {
            _ in
            self.showInfo()
        }, for: .touchUpInside)
        view.addSubview(infoButton)
        
        infoButton.snp.makeConstraints({ make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.height.equalTo(view.snp.width).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        })
        
        restartButton = UIButton(type: .custom)
                restartButton.setImage(UIImage(named: "btn_restart"), for: .normal)
                restartButton.imageView?.contentMode = .scaleAspectFit
                restartButton.addAction(UIAction() {
                    _ in
                    self.box.isHidden = true
                    self.restartGame()
                }, for: .touchUpInside)
                view.addSubview(restartButton)

                restartButton.snp.makeConstraints({ make in
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
                    make.centerX.equalTo(view)
                    make.height.equalTo(view.snp.width).multipliedBy(0.2)
                    make.width.equalTo(view.snp.width).multipliedBy(0.2)
                })
    }
    
    func restartGame() {
            playButton.isHidden = false
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            box.isHidden = false
            view.viewWithTag(2)?.removeFromSuperview()
        }
    
    func showInfo() {
        view.viewWithTag(3)?.removeFromSuperview()
            let imageView = UIImageView(image: UIImage(named: "information"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = 3
            view.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            ])
        }
    
    @objc func handleTap() {
        view.viewWithTag(3)?.removeFromSuperview()
        }
    
}

import UIKit

class VersusView: UIView {
    
    let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Box_R")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let versusLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.numberOfLines = 0
        label.font = UIFont(name: "Victoire", size: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 3, height: 3)
        label.shadowColor = .magenta
        return label
    }()
    
    let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Box_R")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lose")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(firstImageView)
        firstImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstImageView.topAnchor.constraint(equalTo: topAnchor),
            firstImageView.heightAnchor.constraint(equalToConstant: 60),
            firstImageView.widthAnchor.constraint(equalToConstant: 60)
        ])

        addSubview(versusLabel)
        
        addSubview(secondImageView)
        secondImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondImageView.topAnchor.constraint(equalTo: topAnchor),
            secondImageView.heightAnchor.constraint(equalToConstant: 60),
            secondImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        versusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            versusLabel.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor),
            versusLabel.topAnchor.constraint(equalTo: topAnchor),
            versusLabel.heightAnchor.constraint(equalToConstant: 60),
            versusLabel.trailingAnchor.constraint(equalTo: secondImageView.leadingAnchor)
        ])

        addSubview(bottomImageView)
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomImageView.topAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: 10),
            bottomImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

enum res {
    case win
    case loose
    case draw
}

