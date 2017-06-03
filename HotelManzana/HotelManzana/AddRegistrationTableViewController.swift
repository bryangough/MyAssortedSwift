//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Bryan Gough on 2017-06-02.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
    var new: Bool = true
}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName:"PHS", price: 309)]
    }
}

//Equatable Protocol Implementation for RoomType
func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}

protocol EditExistingRoomDelegate {
    func setRegistration(inReg: Registration)
}


class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate, EditExistingRoomDelegate {

    var newReg:Bool = true
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberofAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    var roomType: RoomType?
    
    @IBOutlet var doneButton: UIBarButtonItem!
    
    @IBAction func wifiSwitchChanged(_ sender: Any) {
        updateTotals()
    }
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    func updateDoneButton(){
        if registration == nil{
            doneButton.isEnabled = false
        }
        else{
            doneButton.isEnabled = true
        }
    }
    
    func updateNumberOfGuests(){
        numberOfAdultsLabel.text = "\(Int(numberofAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
        
    }
    @IBAction func stepperChanged(_ sender: Any) {
        updateNumberOfGuests()
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        updateDateViews()
        
    }
    
    
    func updateDateViews()
    {
        //at start of update date views
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        updateTotals()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //in view did load
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        initRegistration()
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        updateDoneButton()
        updateTotals()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
            case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
            case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
            default: return 44.0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section,
              checkInDatePickerCellIndexPath.row - 1):
            
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section,
              checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
   
    func updateRoomType(){
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
        updateDoneButton()
        updateTotals()
    }
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
        
    }
    
    var registration: Registration? {
        
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberofAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        if newReg
        {
            return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
            numberOfAdults: numberOfAdults,
            numberOfChildren: numberOfChildren,
            roomType: roomType,
            wifi: hasWifi,
            new: newReg)
        }
        else
        {
            currentRegistration?.firstName = firstName
            currentRegistration?.lastName = lastName
            currentRegistration?.emailAddress = email
            currentRegistration?.checkInDate = checkInDate
            currentRegistration?.numberOfAdults = numberOfAdults
            currentRegistration?.numberOfChildren = numberOfChildren
            currentRegistration?.roomType = roomType
            currentRegistration?.wifi = hasWifi
            currentRegistration?.new = false
            return currentRegistration
        }
    }
    var currentRegistration:Registration?
    
    func setRegistration(inReg:Registration)
    {
        currentRegistration = inReg
    }
    func initRegistration()
    {
        print("set reg")
        if let inReg = currentRegistration
        {
            firstNameTextField.text = inReg.firstName
            lastNameTextField.text = inReg.lastName
            emailTextField.text = inReg.emailAddress
            checkInDatePicker.date = inReg.checkInDate
            checkOutDatePicker.date  = inReg.checkOutDate
            numberofAdultsStepper.value = Double(inReg.numberOfAdults)
            numberOfChildrenStepper.value = Double(inReg.numberOfChildren)
            roomType = inReg.roomType
            wifiSwitch.isOn = inReg.wifi
            newReg = false
        }
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
   
    @IBOutlet var numberOfNightsLabel: UILabel!
    @IBOutlet var roomTypeCost: UILabel!
    @IBOutlet var roomTypeShort: UILabel!
    @IBOutlet var wifiBool: UILabel!
    @IBOutlet var wifiCost: UILabel!
    @IBOutlet var TotalCost: UILabel!
    
    func updateTotals()
    {
        let date = checkOutDatePicker.date
        let f = date.timeIntervalSince(checkInDatePicker.date)
        
        let numDays:Int = Int(f/86400)
        numberOfNightsLabel.text = "\(numDays)"
        var roomCostVal = 0
        
        if let roomType = roomType {
            roomCostVal = numDays * roomType.price
            roomTypeShort.text = roomType.shortName
        }
        else
        {
            roomTypeShort.text = ""
        }
        roomTypeCost.text = "$\(roomCostVal)"
        
        var wifiCostVal = 10 * numDays
        
        
        if wifiSwitch.isOn
        {
            wifiBool.text = "YES"
        }
        else
        {
            wifiBool.text = "NO"
        }
        
        if(wifiSwitch.isOn)
        {
            wifiCost.text = "$\(wifiCostVal)"
        }
        else
        {
            wifiCost.text = "$0"
            wifiCostVal = 0;
        }
        let total = roomCostVal + wifiCostVal
        TotalCost.text = "$\(total)"
    }

}
