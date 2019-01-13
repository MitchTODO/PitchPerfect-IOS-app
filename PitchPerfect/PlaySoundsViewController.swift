//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by mitch on 1/11/19.
//  Copyright © 2019 mitch. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: PlaySoundsClass for ViewController
class PlaySoundsViewController: UIViewController {
    
    // MARK: Outlet Buttons
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Audio variables
    // audio variables
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    // MARK playSoundForButton
    // case for type by tag number of button
    enum ButtonType: Int {
        case slow = 0, fast, echo, reverb, high, low
    }
    
    // match the correct type to the correct playback
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .high:
            playSound(pitch: 1000)
        case .low:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // MARK: stopButtonPressed
    // stop the audio
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
        configureUI(.notPlaying)
    }
    
    // MARK: viewDidLoad
    // setupAudio
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    // MARK: viewWillAppear
    // stopped button is disabled on start of page
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    

}
