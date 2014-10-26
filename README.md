# ROFilterSort

[![CI Status](http://img.shields.io/travis/Brian Weinreich/ROFilterSort.svg?style=flat)](https://travis-ci.org/Brian Weinreich/ROFilterSort)
[![Version](https://img.shields.io/cocoapods/v/ROFilterSort.svg?style=flat)](http://cocoadocs.org/docsets/ROFilterSort)
[![License](https://img.shields.io/cocoapods/l/ROFilterSort.svg?style=flat)](http://cocoadocs.org/docsets/ROFilterSort)
[![Platform](https://img.shields.io/cocoapods/p/ROFilterSort.svg?style=flat)](http://cocoadocs.org/docsets/ROFilterSort)

ROFilterSort is part of the Rounded UI Kit framework. Other notable pieces of the framework are the ROCardToss and ROTranslucentView.

ROFilterSort is an easy-to-use framework that allows users to filter a given screen via a segment control and filter buttons. The ROFilterBar shows the currently selected filters, and launching the ROFilterSortView displays the different filters that can be applied. 

For example, if you have a list of wines in a `UITableView` you can easily view how the wines are sorted alphabetically and filtered by "red" wine. If you'd like to change the filters, you launch the `ROFilterSortView` and click enable the "red" "white" and "sparkling" filters while also sorting by "year."

## To do

* Need to come up with better naming conventions. Right now they are incredibly verbose.. Maybe something like, `ROFilterSort`, `ROFilterSort.bar` and `ROFilterSort.popupView`.

* Add credit for PureLayout, Pop, RSNSMutableIndexSetMake.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ROFilterSort is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ROFilterSort"

## Author

Brian Weinreich at Rounded, bw@roundedco.com

## License

ROFilterSort is available under the MIT license. See the LICENSE file for more info.

