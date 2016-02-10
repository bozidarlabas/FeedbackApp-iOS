//
//  FeedbackViewController.swift
//  FeedbackApp
//
//  Created by Bozidar on 10.02.2016..
//  Copyright © 2016. Bozidar. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initCamera()
        self.hidesBottomBarWhenPushed = true
        
        // Do any additional setup after loading the view.
    }
    
    func initCamera(){
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
    }

    @IBAction func takeImage(sender: UIButton) {
        //presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCancelClicked(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
}
