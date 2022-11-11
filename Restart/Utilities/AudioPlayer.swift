//
//  AudioPlayer.swift
//  Restart
//
//  Created by Philip Al-Twal on 10/12/22.
//

import Foundation
import AVFoundation

class RAudioPlayer {
    static let shared: RAudioPlayer = .init()
    private var audioPlayer: AVAudioPlayer?

    func play(with fileName: String, type: String){
        if let path = Bundle.main.path(forResource: fileName, ofType: type) {
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
//                audioPlayer?.play()
            }catch{
                print("Error [  ] Could not play sound file!")
            }
        }
    }
}
