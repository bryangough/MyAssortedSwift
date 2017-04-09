//
//  TimeViewController.swift
//  SailStarter
//
//  Created by Bryan Gough on 2017-04-08.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//
// https://developer.apple.com/reference/uikit/uipickerview
// http://stackoverflow.com/questions/29617835/how-do-i-setup-a-second-component-with-a-uipickerview
// http://stackoverflow.com/questions/35708300/showing-uipickerview-with-selected-row
// http://stackoverflow.com/questions/26063039/uipickerview-loop-the-data
// https://makeapppie.com/2014/10/21/swift-swift-formatting-a-uipickerview/
//
import UIKit

class TimePicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let minutes:[Int] = Array(0...5)
    let seconds:[Int] = [0,15,30,45]
    
    private let secondsRows:Int = 400
    private var secondsMiddle:Int = 200
    
    var selectedMinutes = 0
    var selectedSeconds = 0
    let initialMinutes = 5
    let initialSeconds = 0
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doinit()
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        doinit()
    }
    func doinit()
    {
        secondsMiddle = ((secondsRows / seconds.count) / 2) * seconds.count
        self.delegate = self
        self.dataSource = self
        self.selectRow(initialMinutes, inComponent: 0, animated: true)
        //self.selectedMinutes = minutes[initialMinutes]
        self.pickerView(self, didSelectRow: initialMinutes, inComponent: 0)
        if let row = rowForValue(data: seconds, middle: secondsMiddle, value: initialSeconds) {
            self.selectRow(row, inComponent: 2, animated: false)
            //self.selectedSeconds = valueForRow(data: seconds, row: row)
            self.pickerView(self, didSelectRow: row, inComponent: 2)
        }
    }
    // MARK: - Helpers
    // These are used to make the seconds part seem infinite
    func valueForRow(data:[Int], row: Int) -> Int {
        // the rows repeat every `seconds` items
        return data[row % data.count]
    }
    
    func rowForValue(data:[Int], middle: Int, value: Int) -> Int? {
        if let valueIndex = data.index(of: value ){
            return middle + valueIndex
        }
        return nil
    }
    
    // MARK: - UIPickerViewDataSource required files
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //let row = pickerView.selectedRow(inComponent: 0)
        //print("this is the pickerView\(row)")
        
        if component == 0 {
            return minutes.count
        }
        else if component == 1 {
            return 1
        }
            
        else {
            return secondsRows//seconds.count
        }
        
    }
    // MARK: - UIPickerViewDelegate required files
    /*func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 150
    }*/
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }

    /*func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        if component == 0 {
            return NSAttributedString.init(string:"\(minutes[row]):")
        } else {
            
            return NSAttributedString.init(string:"\(seconds[row])")
        }
    }*/
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(minutes[row])
        }
        else if component == 1 {
            return ":"
        }
        else {
            
            return formatSeconds(sec:valueForRow(data: seconds, row: row))
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as! UILabel!
        if view == nil {
            pickerLabel = UILabel()
            //color the label's background
            //let hue = CGFloat(row)/CGFloat(pickerData.count)
            //pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        var titleData = ""
        if component == 0 {
            titleData =  String(minutes[row])
            pickerLabel!.textAlignment = .right
        }
        else if component == 1 {
            titleData = ":"
            pickerLabel!.textAlignment = .center
            pickerLabel!.textColor = UIColor.blue
        }
        else {
            titleData = formatSeconds(sec:valueForRow(data: seconds, row: row))
            pickerLabel!.textAlignment = .left
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 50.0)!])
        //,NSForegroundColorAttributeName:UIColor.black
        pickerLabel!.attributedText = myTitle
        //pickerLabel!.text = titleData
        
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1
        {
            self.selectRow(row, inComponent: component, animated: false)
            return
        }
        let pickerLabel:UILabel = self.view(forRow: row, forComponent: component) as! UILabel!
        pickerLabel.textColor = UIColor.blue
        
        if component == 0 {
            selectedMinutes = row
        }
        else if component == 1 {
            //do nothing
        }
        else {
            
            selectedSeconds = valueForRow(data: seconds, row: row)
        }
    }
    // MARK: - getter
    func getTime()-> Double
    {
        let selected:Double = Double(minutes[selectedMinutes]*60 + seconds[selectedSeconds])
        print("\(selected) \(minutes[selectedMinutes]) \(seconds[selectedSeconds])")
        return selected
    }
    func formatSeconds(sec:Int) -> String {
        if(sec>10)
        {
            return String(sec)
        }
        else
        {
          return "0"+String(sec)
        }
    }
}
