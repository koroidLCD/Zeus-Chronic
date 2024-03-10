import UIKit
import SnapKit

class menuViewContoller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //wtf
        let background = UIImageView()
        background.frame = view.frame
        view.addSubview(background)
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named: "background")
        
        let logo = UIImageView()
        view.addSubview(logo)
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named: "logo")
        logo.snp.makeConstraints({ make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        let eButton = UIButton(type: .custom)
        eButton.setImage(UIImage(named: "play"), for: .normal)
        eButton.imageView?.contentMode = .scaleAspectFit
        eButton.addAction(UIAction() {
            _ in
            let vc = lvlViewContoller()
            vc.modalTransitionStyle = .crossDissolve
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
        mButton.setImage(UIImage(named: "chronicles"), for: .normal)
        mButton.imageView?.contentMode = .scaleAspectFit
        mButton.addAction(UIAction() {
            _ in
            let vc = ChroniclesVC()
            vc.modalTransitionStyle = .crossDissolve
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
        hButton.setImage(UIImage(named: "olymic_game"), for: .normal)
        hButton.imageView?.contentMode = .scaleAspectFit
        hButton.addAction(UIAction() {
            _ in
            let vc = OlympicGameVC()
            vc.modalTransitionStyle = .crossDissolve
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
    }
    
}
