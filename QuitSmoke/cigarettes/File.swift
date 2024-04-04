//
//  File.swift
//  cigarettes
//
//  Created by Gianmarco Cremisi on 26/03/24.
//

import Foundation
import UIKit
import DotLottie
import SwiftUI


//class ViewController: UIViewController {
//    var animationView: LottieAnimationView = .init()
//    override func viewDidLoad () {
//    super.viewDidLoad()
//    animationView.animation =
//        Animation. ("Animation - 1711461440181")
//    animationView.loopMode = .loop
//    animationView.play()
//    view = animationView
//    }
//    }

struct AnimationView: View {
    var body: some View {
        DotLottieAnimation(fileName: "Animation - 1711461440181", config: AnimationConfig(autoplay: true, loop: true)).view()
    }
}
 
    
