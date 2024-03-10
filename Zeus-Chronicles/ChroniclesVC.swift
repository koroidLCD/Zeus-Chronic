import UIKit
import SnapKit

class ChroniclesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images = [UIImage(named: "chronicle_1"),
                  UIImage(named: "chronicle_2"),
                  UIImage(named: "chronicle_3"),
                  UIImage(named: "chronicle_4"),
                  UIImage(named: "chronicle_5"),
                  UIImage(named: "chronicle_6")]
    
    let labels = ["Collect 100 lightning points!",
                  "Collect 500 lightning points!",
                  "Collect 1000 lightning points!",
                  "Get win in Olympic Game 20 times!",
                  "Get win in Olympic Game 50 times!",
                  "Get win in Olympic Game 100 times!",]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labels.first
        label.numberOfLines = 0
        label.font = UIFont(name: "Victoire", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 3, height: 3)
        label.shadowColor = .magenta
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lightning = LightningManager.shared.getLightPoints()
        let olymp = LightningManager.shared.getOlympPoints()
        
            if lightning < 100 {
                images[0] = images[0]?.imageWithAlpha(alpha: 0.5)
            }

            if lightning < 500 {
                images[1] = images[1]?.imageWithAlpha(alpha: 0.5)
            }

            if lightning < 1000 {
                images[2] = images[2]?.imageWithAlpha(alpha: 0.5)
            }

            if olymp < 20 {
                images[3] = images[3]?.imageWithAlpha(alpha: 0.5)
            }

            if olymp < 50 {
                images[4] = images[4]?.imageWithAlpha(alpha: 0.5)
            }

            if olymp < 100 {
                images[5] = images[5]?.imageWithAlpha(alpha: 0.5)
            }
        
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
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        })
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
        ])
        
        view.addSubview(label)
        
        
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
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: backButton.topAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.imageView.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.width * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateLabelForVisibleCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateLabelForVisibleCell()
        }
    }
    
    func updateLabelForVisibleCell() {
        let indexPaths = collectionView.indexPathsForVisibleItems
        guard let firstIndexPath = indexPaths.first else {
            return
        }
        let visibleLabel = labels[firstIndexPath.item]
        UIView.transition(with: self.label, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.label.text = visibleLabel
        })
    }
    
}

class LightningManager {
    
    static let shared = LightningManager()
    
    public func addLightPoints(_ points: Int) {
        if let retrievedValue = UserDefaults.standard.object(forKey: "light") as? Int {
            let newValue = retrievedValue + points
            UserDefaults.standard.set(newValue, forKey: "light")
        } else {
            UserDefaults.standard.set(points, forKey: "light")
        }
    }
    
    func getLightPoints() -> Int {
        if let retrievedValue = UserDefaults.standard.object(forKey: "light") as? Int {
            return retrievedValue
        } else {
            UserDefaults.standard.set(0, forKey: "light")
            return 0
        }
    }
    
    public func addOlympPoints(_ points: Int) {
        if let retrievedValue = UserDefaults.standard.object(forKey: "olymp") as? Int {
            let newValue = retrievedValue + points
            UserDefaults.standard.set(newValue, forKey: "olymp")
        } else {
            UserDefaults.standard.set(points, forKey: "olymp")
        }
    }
    
    func getOlympPoints() -> Int {
        if let retrievedValue = UserDefaults.standard.object(forKey: "olymp") as? Int {
            return retrievedValue
        } else {
            UserDefaults.standard.set(0, forKey: "olymp")
            return 0
        }
    }
    
}


class ImageCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func imageWithAlpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPointZero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
