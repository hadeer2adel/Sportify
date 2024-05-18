//
//  SplashViewController.swift
//  Sportify
//
//  Created by Hadeer Adel Ahmed on 16/05/2024.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    var ainimation: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ainimation = .init(name: "Sprotifiy.json")
        ainimation!.frame = view.bounds
        ainimation!.backgroundColor = .white
        ainimation!.contentMode = .scaleAspectFit
        ainimation!.loopMode = .loop
        ainimation!.play()
        view.addSubview(ainimation)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
