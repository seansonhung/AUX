//
//  ViewController.swift
//  Test
//
//  Created by Sean Nguyen on 2020-11-08.
//

import youtube_ios_player_helper
import UIKit

class ViewController: UIViewController, YTPlayerViewDelegate{
    
    @IBOutlet var playerView: YTPlayerView!
    
    //go to bluetooth page when tap button
    @IBAction func didTapButton(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "blueToothStoryboard") as? BluetoothController else {
            print("failed to get vc from storyboard")
            return
        }
        //This is to full screen the new view, default is not
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set it so that we can configure it
        playerView.delegate = self
        //load video, playerVars allow us to configure it so that when it play
        //it doesnt go to full screen.
        playerView.load(withVideoId: "NvsTDJzorSw", playerVars: ["playsinline": 1])
    }
    
    //play video when it is ready automatically
    //func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
    //    playerView.playVideo()
    //}
    


}
