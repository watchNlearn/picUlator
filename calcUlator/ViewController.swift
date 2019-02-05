//
//  ViewController.swift
//  calcUlator/picUlator
//
//  Created by Caleb Lee on 7/18/18.
//  Copyright © 2018 WithoutAnyLimits. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
   // var selectedImageTag = 0
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            myImageView.image = UIImage(contentsOfFile: imagePath)
        }else{
            print("No Existing Image")
        }
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func importImage(_ sender: UIButton) {
        
        
        
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary //photo library
        image.allowsEditing = false //catch
        self.present(image, animated: true) {
            //only used for selection?
        }
      
    }
    //var firstPic = true
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage { //once selected button creates image ->image
            myImageView.image = image
            //saveImage(imageName: "test.png")
            saveImage(imageName: "background.png") //load last chosen image

        }
        else {
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
        func saveImage(imageName: String){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = myImageView.image!
        //get the PNG data for this image
        let data = UIImagePNGRepresentation(image)
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        print(imagePath)
        
    }
    
    
   

    
    // ------------------------------------------------------------------------------//
    //Numeric Calculation/Calculator Part
    var firstNumber: Double! = nil
    var finalNumber: Double! = nil
    var sign: String = ""
    var answer: Double = 0
    var newEquation = false
    var decimalAdded = false
    var equalsPressed = false
    var checkDoubleOp = false
    
    @IBOutlet weak var label: UILabel!
   
    @IBAction func numbers(_ sender: UIButton) {
      
     /*
        if checkDoubleOp == true {
            if sender.tag == 11{
                label.text = "nil"
                    
                
               
        
                
            }
            checkDoubleOp = false
        }
 */
        if equalsPressed == true {
           
            if sender.tag == 11 || sender.tag == 12 || sender.tag == 13 || sender.tag == 14  {
                newEquation = false
                
                //label.text = "7678"
               //sign = label.text!
                
            }
            else if sender.tag == 16{
                label.text = "."
                decimalAdded = true
                newEquation = true
            }
                // starting with a number aka not operator
            else {
                newEquation = true
            }
            equalsPressed = false
        }

        // && checkDoubleOp == false
        if answer == 0{ //if no operation/equation done
            //if label.text != ""{
            if label.text == "+" {
            label.text = sender.currentTitle// clears screen -> replaces with operator
            decimalAdded = false
            //checkDoubleOp = true
            }
            else if label.text == "-" {
            label.text = sender.currentTitle
            decimalAdded = false
            //checkDoubleOp = true

            }
            else if label.text == "x"{
            label.text = sender.currentTitle
            decimalAdded = false
            //checkDoubleOp = true

            }
            else if label.text == "/"{
            label.text = sender.currentTitle
            decimalAdded = false
            //checkDoubleOp = true

            }
            
            else if sender.tag == 16 {
                if decimalAdded == false {
                    label.text = label.text! + String(".")
                    decimalAdded = true
                }
            
            }
           
            else if sender.currentTitle != "+" && sender.currentTitle != "-" && sender.currentTitle != "x" && sender.currentTitle != "/" {
                label.text = label.text! + String(sender.tag)
                //label.text = "dd"
            }
            
            
            
        
        }
                                        // answer + input number = newEquation
                                   // && checkDoubleOp == false
        else if  newEquation == true  { //newEquation == two numbers pressed consecutivley
            label.text = ""
            answer = 0
            firstNumber = 0
            finalNumber = 0
            sign = ""
            if label.text != "" {
            if label.text == "+" {
                label.text = sender.currentTitle
                decimalAdded = false
            }
            else if label.text == "-" {
                label.text = sender.currentTitle
                    //String(sender.tag)
                decimalAdded = false
            }
            else if label.text == "x"{
                label.text = sender.currentTitle
                decimalAdded = false
            }
            else if label.text == "/"{
                label.text = sender.currentTitle
                decimalAdded = false
            }
            else if sender.tag == 16 {
                if decimalAdded == false {
                    label.text = label.text! + String(".")
                    decimalAdded = true
                }
                
                
            }
            else {
                //label.text = "test"
                label.text = label.text! + String(sender.tag)
            }
            }
            else {
                label.text = label.text! + sender.currentTitle!
               // label.text = "po"
            }
           
        }
                                    //&& checkDoubleOp == false
        else if newEquation == false {// answer + opperator
            //firstNumber = answer
            if label.text == "+" {
                label.text = sender.currentTitle// clears screen -> replaces with operator
                decimalAdded = false
            }
            else if label.text == "-" {
                label.text = sender.currentTitle
                decimalAdded = false
            }
            else if label.text == "x"{
                label.text = sender.currentTitle
                decimalAdded = false
            }
            else if label.text == "/"{
                label.text = sender.currentTitle
                decimalAdded = false
            }
            else if sender.tag == 16 {
                if decimalAdded == false {
                    label.text = label.text! + String(".")
                    decimalAdded = true
                }
                
                
            }
            else {
                label.text = label.text! + String(sender.tag)
            }
            //label.text = "7678"
        }
    
    }

     // delete this if count fail
    
    
    @IBAction func buttons(_ sender: UIButton) {//opperations
        // = = 10
        // + = 11
        // - = 12
        // x = 13
        // / = 14
        // c = 15
        // . = 16
                            //&& checkDoubleOp == false
        if label.text != "" && label.text != "+" && label.text != "-" && label.text != "x" && label.text != "/" && label.text != "."{
                               //added && count != 1
            if sender.tag == 11{
                //checkDoubleOp = true
                firstNumber = Double(label.text!)!
                sign = "+"
                label.text = "+"
                decimalAdded = false
                //count += 1
                //checkDoubleOp = true
                
            }
            else if sender.tag == 12 {
                
                firstNumber = Double(label.text!)!
                sign = "-"
                label.text = "-"
                decimalAdded = false
                //checkDoubleOp = true //changed this /not work delete
            }
            else if sender.tag == 13 {
                firstNumber = Double(label.text!)!
                sign = "x"
                label.text = "x"
                decimalAdded = false
                //checkDoubleOp = true
            }
            else if sender.tag == 14 {
                firstNumber = Double(label.text!)!
                sign = "/"
                label.text = "/"
                decimalAdded = false
                //checkDoubleOp = true
            }
        
            else if sender.tag == 15 {
                firstNumber = 0
                finalNumber = 0
                answer = 0
                sign = ""
                label.text = ""
                decimalAdded = false
                //checkDoubleOp = true
                
            }
            
          
            
            
            else if sender.tag == 10 {//equals [=]
                if firstNumber != nil {
                    finalNumber = Double(label.text!)!
                    if sign == "+" {
                        answer = firstNumber + finalNumber
                        label.text = String(answer)
                        //product = answer
                        //newEquation = true
                        equalsPressed = true
                    }
                    else if sign == "-" {
                        answer = firstNumber - finalNumber
                        label.text = String(answer)
                        //answer = product
                        //newEquation = true
                        equalsPressed = true

                    }
                    else if sign == "x" {
                        answer = firstNumber * finalNumber
                        label.text = String(answer)
                        //answer = product
                        //newEquation = true
                        equalsPressed = true

                    }
                    else if sign == "/" {
                        answer = firstNumber / finalNumber
                        label.text = String(answer)
                        //answer = product
                        //newEquation = true
                        equalsPressed = true

                    }
                    
                }
                //equalsPressed = true
                //label.text = "7678"
            }
        
        }
        else if sender.tag == 15 {
            firstNumber = 0
            finalNumber = 0
            answer = 0
            sign = ""
            label.text = ""
            decimalAdded = false
            //checkDoubleOp = true
            
        }
    }
    
    

    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagePickerController.delegate = self
        //fetchData()
        // Do any additional setup after loading the view, typically from a nib.
       // view.getImage(imageName: "test.png")
        getImage(imageName: "background.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

