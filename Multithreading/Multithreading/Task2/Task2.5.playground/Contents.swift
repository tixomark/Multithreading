import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(2)
        
        DispatchQueue.main.async {
            print(3)
            
            DispatchQueue.main.async {
                print(5)
            }
            
            print(4)
        }
        
        print(6)
    }
}

let vc = ViewController()
print(1)


/*
 Из доки(почему вызвался viewDidLoad)
 This property represents the root view of the view controller's view hierarchy. The default value of this property is nil.
 If you access this property when its value is nil, the view controller automatically calls the loadView() method and returns the resulting view.
 */

let view = vc.view
print(7)

