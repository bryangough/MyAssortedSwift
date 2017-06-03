//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Bryan Gough on 2017-06-02.
//  Copyright © 2017 Bryan Gough. All rights reserved.
//

import UIKit


class RegistrationTableViewController: UITableViewController {

    var registrations: [Registration] = []
    var delegate: EditExistingRoomDelegate?
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name
        
        return cell
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
            let registration = addRegistrationTableViewController.registration else{ return }
        
        registrations.append(registration)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("table view \(indexPath.row)")
        delegate?.setRegistration(inReg:  registrations[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditRoom" {
            print("prepare EditRoom")
            let destinationViewController = segue.destination as? EditExistingRoomDelegate
            delegate = destinationViewController
        }
    }

}
