//
//  TestHelpers.swift
//  TableViewTests
//
//  Created by Ayemere  Odia  on 2022/12/01.
//

import UIKit

func numberOfRows(in tableView: UITableView, section: Int = 0) -> Int? {
    tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section)
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
    tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
}
