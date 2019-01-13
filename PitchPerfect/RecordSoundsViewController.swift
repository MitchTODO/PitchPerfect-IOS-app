//
//  ViewController.swift
//  PitchPerfect
//
//  Created by mitch on 1/10/19.
//  Copyright © 2019 mitch. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: RecordSoundsViewController

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: RecordSounds UIButtons
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecodingButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    // MARK: viewDidLoad
    // make stopRecording button disabled
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecodingButton.isEnabled = false
    }
    
    // MARK: viewWillAppear
    // excute after viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: recordAudio
    // Action when record button is pressed
    
    @IBAction func recordAudio(_ sender: Any) {
        recordLabel.text = "Recording in Progress..."
        stopRecodingButton.isEnabled = true     // Enable stopRecord button
        recordButton.isEnabled = false          // Disble startRecord button
        
        // MARK: save audio file
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav" // .wav
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        // Start the audio recording and save it to the url created above
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    // MARK: stopRecording
    
    @IBAction func stopRecording(_ sender: Any) {
        recordLabel.text = "Tap to record"
        stopRecodingButton.isEnabled = false    // Disable stopRecoding button
        recordButton.isEnabled = true           // Enable recording button
        audioRecorder.stop()                    // stop the audioRecording
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: audioRecorderDidFinishRecording/create segue
    // set up segue
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier:"stopRecording", sender: audioRecorder.url)
        }else{
            print ("recording was not successful")
        }
    }
    
    // send seque to playsoundsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

