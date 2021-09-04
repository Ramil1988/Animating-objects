
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var numberOfEpisde: UILabel!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfEpisde.text = "\(value)"
    }
    
    @IBAction func previousBtn() {
        value -= 1
        minMaxValue()
        numberOfEpisde.text = "\(value)"
        switchNumber()
    }
    @IBAction func nextBtn() {
        value += 1
        minMaxValue()
        numberOfEpisde.text = "\(value)"
        switchNumber()
    }

    func minMaxValue(){
        if value >= 8 {
            value = 0
        } else if value <= 0 {
            value = 7
        }
    }
    
    func changeBackgroungColor() {
        UIView.animate(withDuration: 2) {
            self.squareView.backgroundColor = .yellow
        } completion: { _ in
            self.originState()
        }
    }
  
    func replace(){
        UIView.animate(withDuration: 2) {
            self.bottomConstraint.constant = self.bottomConstraint.constant + self.topConstraint.constant
            self.topConstraint.constant = 0
            self.leadingConstraint.constant = 16
            self.trailingConstraint.constant = UIScreen.main.bounds.width - self.squareView.frame.size.width - 16
            self.squareView.layer.layoutIfNeeded()
        } completion: { _ in
            self.originState()
        }
    }
    
    func rounded() {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: Float(self.squareView.frame.size.width / 2))
        animation.duration = 2.0
        squareView.layer.add(animation, forKey: "cornerRadius")
    }

    func upSideDown(){
        UIView.animate(withDuration: 2) {
            self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } completion: { _ in
            self.originState()
        }
    }

    func cubeDisappear() {
        UIView.animate(withDuration: 2) {
            self.squareView.alpha = 0
        } completion: { _ in
            self.originState()
        }
        
    }
    
    func growUp(){
        UIView.animate(withDuration: 2, delay: 0, options: UIView.AnimationOptions.autoreverse) {
            self.topConstraint.constant = self.topConstraint.constant - self.squareView.frame.size.height / 2
            self.leadingConstraint.constant = self.leadingConstraint.constant / 2
            self.trailingConstraint.constant = self.trailingConstraint.constant / 2
            self.bottomConstraint.constant = self.bottomConstraint.constant - self.squareView.frame.size.height / 2
            self.squareView.layer.layoutIfNeeded()
        } completion: { _ in
            self.originState()
        }
    }
    
    func spin(){
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Float.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        self.squareView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func switchNumber() {
        switch numberOfEpisde.text {
        case "1": changeBackgroungColor()
        case "2": replace()
        case "3": rounded()
        case "4": upSideDown()
        case "5": cubeDisappear()
        case "6": growUp()
        case "7": spin()
        default: originState()
        }
    }
    
    func originState() {
        squareView.backgroundColor = .red
        squareView.frame.size.height = 300
        squareView.frame.size.width = 300
        
        topConstraint.constant = 200
        leadingConstraint.constant =
            (UIScreen.main.bounds.width - squareView.frame.size.width) / 2
        trailingConstraint.constant =
            (UIScreen.main.bounds.width - squareView.frame.size.width) / 2
        bottomConstraint.constant =
            UIScreen.main.bounds.height - topConstraint.constant - squareView.frame.size.height - 78
        squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        squareView.alpha = 1
        self.squareView.layer.removeAllAnimations()
    }
}
