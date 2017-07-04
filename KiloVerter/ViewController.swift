//
//  ViewController.swift
//  KiloVerter
//
//  Created by Steve  Tran on 3/28/17.
//  Copyright © 2017 Steve  Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fromTot = 0.0
    var toAmt = 0.0
    var amt25 = 0.0
    var amt20 = 0.0
    var amt15 = 0.0
    var amt10 = 0.0
    var amt5 = 0.0
    var amt2p5 = 0.0
    var amt2p0 = 0.0
    var amt1p5 = 0.0
    var amt1p0 = 0.0
    var amt0p5 = 0.0
    var btnOn20 = true
    var btnOn15 = false
    var btnNoBarTog = false
    var barWeight = 0.0
    var convFromLBS = true
    var convFromKG = false
    
    
    //Labels for num of plates
    
    @IBOutlet weak var fromkg: UILabel!
    
    @IBOutlet weak var tolbs: UILabel!
    
    @IBOutlet weak var btn20: UIButton!
    
    @IBOutlet weak var btn15: UIButton!
   
    
    @IBOutlet weak var straightConvAmt: UITextField!
    
    @IBOutlet weak var convOutcome: UILabel!
    
    @IBAction func straightConvBtn(_ sender: UIButton) {
        if let toConv = Double(straightConvAmt.text!) {
            print("The user entered a weight of \(toConv)")
            straightConvert(toBeConv:toConv )
        } else {
            print("Not a valid number: \(straightConvAmt.text!)")
        }
    }
    
    
    @IBAction func btn20Pressed(_ sender: UIButton) {
        btnNoBarTog = false
        btnOn15 = false
        btnOn20 = true
        btn20.backgroundColor = UIColor(red:1.00, green:1.00, blue:0.59, alpha:1.0)
        btn15.backgroundColor = UIColor.white
    }
    
    @IBAction func btn15Pressed(_ sender: UIButton) {
        btnNoBarTog = false
        btnOn15 = true
        btnOn20 = false
        btn15.backgroundColor = UIColor(red:1.00, green:1.00, blue:0.59, alpha:1.0)
        btn20.backgroundColor = UIColor.white
    }

    @IBAction func lbsBtnPressed(_ sender: Any) {
        convFromLBS = true
        convFromKG = false
        //change text colors on selection
        lbsBtn.setTitleColor(UIColor(red:0.93, green:0.48, blue:0.47, alpha:1.0), for: .normal)
        kgBtn.setTitleColor(UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0), for: .normal)
    }
    @IBAction func kgBtnPressed(_ sender: Any) {
        convFromLBS = false
        convFromKG = true
        //change text colors on selection
        kgBtn.setTitleColor(UIColor(red:0.93, green:0.48, blue:0.47, alpha:1.0), for: .normal)
        lbsBtn.setTitleColor(UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0), for: .normal)
    }
    
    @IBOutlet weak var lbl25: UILabel!
    
    @IBOutlet weak var lbl2p5: UILabel!
    
    @IBOutlet weak var lbl20: UILabel!
    
    @IBOutlet weak var lbl2p0: UILabel!
    
    @IBOutlet weak var lbl15: UILabel!
    
    @IBOutlet weak var lbl1p5: UILabel!
    
    @IBOutlet weak var lbl10: UILabel!
    
    @IBOutlet weak var lbl1p0: UILabel!
    
    @IBOutlet weak var lbl5: UILabel!
    
    @IBOutlet weak var lbl0p5: UILabel!
    
    @IBOutlet weak var lbsBtn: UIButton!
    
    @IBOutlet weak var kgBtn: UIButton!
    
    //Steppers for numPlates
    
    @IBAction func stpr25(_ sender: UIStepper) {
        lbl25.text = "x" + String(sender.value)
        amt25 = sender.value
    }
    
    @IBAction func stpr2p5(_ sender: UIStepper) {
        lbl2p5.text = "x" + String(sender.value)
        amt2p5 = sender.value
    }
    
    
    @IBAction func stpr20(_ sender: UIStepper) {
        lbl20.text = "x" + String(sender.value)
        amt20 = sender.value
    }
    
    
    @IBAction func stpr2p0(_ sender: UIStepper) {
        lbl2p0.text = "x" + String(sender.value)
        amt2p0 = sender.value
    }
    
    
    @IBAction func stpr15(_ sender: UIStepper) {
        lbl15.text = "x" + String(sender.value)
        amt15 = sender.value
    }
    
    
    @IBAction func stpr1p5(_ sender: UIStepper) {
        lbl1p5.text = "x" + String(sender.value)
        amt1p5 = sender.value
    }
    
    @IBAction func stpr10(_ sender: UIStepper) {
        lbl10.text = "x" + String(sender.value)
        amt10 = sender.value
    }
    
    @IBAction func stpr1p0(_ sender: UIStepper) {
        lbl1p0.text = "x" + String(sender.value)
        amt1p0 = sender.value
    }
    
    @IBAction func stpr5(_ sender: UIStepper) {
        lbl5.text = "x" + String(sender.value)
        amt5 = sender.value
    }
    
    @IBAction func stpr0p5(_ sender: UIStepper) {
        lbl0p5.text = "x" + String(sender.value)
        amt0p5 = sender.value
    }
    
    @IBAction func convertBtn(_ sender: UIButton) {
        convertKG()
    }
    
    @IBAction func clearBtn(_ sender: UIButton) {
        clearAll()
    }
    //IBOutlets to access steppers
    @IBOutlet weak var outLet25: UIStepper!
    
    @IBOutlet weak var outLet2p5: UIStepper!
    
    @IBOutlet weak var outLet20: UIStepper!
    
    @IBOutlet weak var outLet2p0: UIStepper!
    
    @IBOutlet weak var outLet15: UIStepper!
    
    @IBOutlet weak var outLet1p5: UIStepper!
    
    @IBOutlet weak var outLet10: UIStepper!
    
    @IBOutlet weak var outLet1p0: UIStepper!
    
    @IBOutlet weak var outLet5: UIStepper!
    
    @IBOutlet weak var outLet0p5: UIStepper!
    
    func convertKG(){
        //Check which bar was chosen
        if btnOn20{
            barWeight = 20.0
        } else if btnOn15{
            barWeight = 15.0
        } else{
            barWeight = 0
        }
        //Calculate amount of total kilograms
        fromTot = barWeight + amt25*25.0 + amt20*20 + amt15*15 + amt10*10 + amt5*5 + amt2p5*2.5 + amt2p0*2.0 + amt1p5*1.5 + amt1p0*1.0 + amt0p5*0.5
        //Calculate resulting pounds
        toAmt = fromTot * 2.204
        fromkg.text = String(fromTot)
        tolbs.text = String(toAmt)
        fromkg.isHidden = false
        tolbs.isHidden = false
    }
    
    func clearAll(){
        fromTot = 0.0
        toAmt = 0.0
        amt25 = 0.0
        amt20 = 0.0
        amt15 = 0.0
        amt10 = 0.0
        amt5 = 0.0
        amt2p5 = 0.0
        amt2p0 = 0.0
        amt1p5 = 0.0
        amt1p0 = 0.0
        amt0p5 = 0.0
        btnOn20 = false
        btnOn15 = false
        btnNoBarTog = true
        barWeight = 0.0
        outLet25.value = 0.0
        lbl25.text = "x" + String(amt25)
        outLet2p5.value = 0.0
        lbl2p5.text = "x" + String(amt2p5)
        outLet20.value = 0.0
        lbl20.text = "x" + String(amt20)
        outLet2p0.value = 0.0
        lbl2p0.text = "x" + String(amt2p0)
        outLet15.value = 0.0
        lbl15.text = "x" + String(amt15)
        outLet1p5.value = 0.0
        lbl1p5.text = "x" + String(amt1p5)
        outLet10.value = 0.0
        lbl10.text = "x" + String(amt10)
        outLet1p0.value = 0.0
        lbl1p0.text = "x" + String(amt1p0)
        outLet5.value = 0.0
        lbl5.text = "x" + String(amt5)
        outLet0p5.value = 0.0
        lbl0p5.text = "x" + String(amt0p5)
        fromkg.text = String(0.0)
        tolbs.text = String(0.0)
        btn20.backgroundColor = UIColor.white
        btn15.backgroundColor = UIColor.white
    }
    
    func straightConvert(toBeConv: Double){
        var output: String
        if convFromLBS{
            toAmt = ((toBeConv/2.204) * 100)
            toAmt.round()
            toAmt /= 100
            output = String(toAmt) + " kilograms"
        }
        else{
            //We are converting from kilograms
            toAmt = toBeConv * 2.204
            output = String(toAmt) + " pounds"
        }
        convOutcome.text = output
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fromkg.isHidden = true
        tolbs.isHidden = true
        btn20.backgroundColor = UIColor(red:1.00, green:1.00, blue:0.59, alpha:1.0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

