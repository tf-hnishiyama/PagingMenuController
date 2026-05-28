# PagingMenuController

[![License](https://img.shields.io/cocoapods/l/PagingMenuController.svg?style=flat)](http://cocoapods.org/pods/PagingMenuController)
[![Platform](https://img.shields.io/cocoapods/p/PagingMenuController.svg?style=flat)](http://cocoapods.org/pods/PagingMenuController)
![Swift 6.0+](https://img.shields.io/badge/Swift-6.0+-orange.svg)

Customizable paging view controller with menu tabs.  
This library is originally forked from [kitasuke/PagingMenuController](https://github.com/kitasuke/PagingMenuController).

## Updates

See [CHANGELOG](https://github.com/tf-hnishiyama/PagingMenuController/blob/master/CHANGELOG.md) for details

## Description

### Standard mode with flexible item width

<img src="https://raw.githubusercontent.com/wiki/kitasuke/PagingMenuController/images/demo4.gif" width="160" height="284">

### Segmented control mode

<img src="https://raw.githubusercontent.com/wiki/kitasuke/PagingMenuController/images/demo2.gif" width="284" height="160">

### Infinite mode with fixed item width

<img src="https://raw.githubusercontent.com/wiki/kitasuke/PagingMenuController/images/demo3.gif" width="160" height="284">

## Customization

### PagingMenuControllerCustomizable

* default page index to show as a first view
```swift
var defaultPage: Int  // default: 0
```

* duration for paging view animation
```swift
var animationDuration: TimeInterval  // default: 0.3
```

* isScrollEnabled for paging view. **Set false in case of using swipe-to-delete on your table view**
```swift
var isScrollEnabled: Bool  // default: true
```

* background color for paging view
```swift
var backgroundColor: UIColor  // default: .white
```

* number of lazy loading pages
```swift
var lazyLoadingPage: LazyLoadingPage  // default: .three

public enum LazyLoadingPage {
    case one   // Currently sets false to isScrollEnabled at this moment.
    case three
    case all   // Currently not available for Infinite mode
}
```

* a set of menu controller
```swift
var menuControllerSet: MenuControllerSet  // default: .multiple

public enum MenuControllerSet {
    case single
    case multiple
}
```

* component type of PagingMenuController
```swift
var componentType: ComponentType

public enum ComponentType {
    case menuView(menuOptions: MenuViewCustomizable)
    case pagingController(pagingControllers: [UIViewController])
    case all(menuOptions: MenuViewCustomizable, pagingControllers: [UIViewController])
}
```

### MenuViewCustomizable

* background color for menu view
```swift
var backgroundColor: UIColor  // default: .white
```

* background color for selected menu item
```swift
var selectedBackgroundColor: UIColor  // default: .white
```

* height for menu view
```swift
var height: CGFloat  // default: 50
```

* duration for menu view animation
```swift
var animationDuration: TimeInterval  // default: 0.3
```

* decelerating rate for menu view
```swift
var deceleratingRate: UIScrollView.DecelerationRate  // default: .fast
```

* center selected menu item
```swift
var selectedItemCenter: Bool  // default: true
```

* menu mode and scrolling mode

```swift
var displayMode: MenuDisplayMode  // default: .standard(widthMode: .flexible, centerItem: false, scrollingMode: .pagingEnabled)

public enum MenuDisplayMode {
    case standard(widthMode: MenuItemWidthMode, centerItem: Bool, scrollingMode: MenuScrollingMode)
    case segmentedControl
    case infinite(widthMode: MenuItemWidthMode, scrollingMode: MenuScrollingMode) // Requires three paging views at least
}

public enum MenuItemWidthMode {
    case flexible
    case fixed(width: CGFloat)
}

public enum MenuScrollingMode {
    case scrollEnabled
    case scrollEnabledAndBouces
    case pagingEnabled
}
```

if `centerItem` is true, selected menu item is always on center

if `MenuScrollingMode` is `.scrollEnabled` or `.scrollEnabledAndBouces`, menu view allows scrolling to select any menu item.  
if `MenuScrollingMode` is `.pagingEnabled`, menu item should be selected one by one.

* menu item focus mode
```swift
var focusMode: MenuFocusMode  // default: .underline(height: 3, color: .blue, horizontalPadding: 0, verticalPadding: 0)

public enum MenuFocusMode {
    case none
    case underline(height: CGFloat, color: UIColor, horizontalPadding: CGFloat, verticalPadding: CGFloat)
    case roundRect(radius: CGFloat, horizontalPadding: CGFloat, verticalPadding: CGFloat, selectedColor: UIColor)
}
```

* dummy item view number for Infinite mode
```swift
var dummyItemViewsSet: Int  // default: 3
```

* menu position

```swift
var menuPosition: MenuPosition  // default: .top

public enum MenuPosition {
    case top
    case bottom
}
```

* divider image to display right aligned in each menu item

```swift
var dividerImage: UIImage?  // default: nil
```

* menu item options
```swift
var itemsOptions: [MenuItemViewCustomizable]
```

### MenuItemViewCustomizable

* horizontal margin for menu item
```swift
var horizontalMargin: CGFloat  // default: 20
```

* menu item mode
```swift
var displayMode: MenuItemDisplayMode  // default: .text(title: MenuItemText())

public enum MenuItemDisplayMode {
    case text(title: MenuItemText)
    case multilineText(title: MenuItemText, description: MenuItemText)
    case image(image: UIImage, selectedImage: UIImage?)
    case custom(view: UIView)
}
```

### MenuItemText

```swift
public struct MenuItemText {
    public init(
        text: String = "Menu",
        color: UIColor = .lightGray,
        selectedColor: UIColor = .black,
        font: UIFont = .systemFont(ofSize: 16),
        selectedFont: UIFont = .systemFont(ofSize: 16)
    )
}
```

## Usage

`import PagingMenuController` to use PagingMenuController in your file.

### Using Storyboard

```swift
struct MenuItem1: MenuItemViewCustomizable {}
struct MenuItem2: MenuItemViewCustomizable {}

struct MenuOptions: MenuViewCustomizable {
    var itemsOptions: [MenuItemViewCustomizable] {
        return [MenuItem1(), MenuItem2()]
    }
}

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [UIViewController(), UIViewController()])
    }
}

let options = PagingMenuOptions()
let pagingMenuController = self.children.first as! PagingMenuController
pagingMenuController.setup(options)
pagingMenuController.onMove = { state in
    switch state {
    case let .willMoveController(menuController, previousMenuController):
        print(previousMenuController)
        print(menuController)
    case let .didMoveController(menuController, previousMenuController):
        print(previousMenuController)
        print(menuController)
    case let .willMoveItem(menuItemView, previousMenuItemView):
        print(previousMenuItemView)
        print(menuItemView)
    case let .didMoveItem(menuItemView, previousMenuItemView):
        print(previousMenuItemView)
        print(menuItemView)
    case .didScrollStart:
        print("Scroll start")
    case .didScrollEnd:
        print("Scroll end")
    }
}
```
* You should add `ContainerView` into your view controller's view and set `PagingMenuController` as the embedded view controller's class

See `PagingMenuControllerDemo` target in demo project for more details

### Coding only
```swift
struct MenuItem1: MenuItemViewCustomizable {}
struct MenuItem2: MenuItemViewCustomizable {}

struct MenuOptions: MenuViewCustomizable {
    var itemsOptions: [MenuItemViewCustomizable] {
        return [MenuItem1(), MenuItem2()]
    }
}

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [UIViewController(), UIViewController()])
    }
}

let options = PagingMenuOptions()
let pagingMenuController = PagingMenuController(options: options)

addChild(pagingMenuController)
view.addSubview(pagingMenuController.view)
pagingMenuController.didMove(toParent: self)
```

See `PagingMenuControllerDemo2` target in demo project for more details

### Menu move handler (optional)

```swift
public enum MenuMoveState {
    case willMoveController(to: UIViewController, from: UIViewController)
    case didMoveController(to: UIViewController, from: UIViewController)
    case willMoveItem(to: MenuItemView, from: MenuItemView)
    case didMoveItem(to: MenuItemView, from: MenuItemView)
    case didScrollStart
    case didScrollEnd
}

pagingMenuController.onMove = { state in
    switch state {
    case let .willMoveController(menuController, previousMenuController):
        print(previousMenuController)
        print(menuController)
    case let .didMoveController(menuController, previousMenuController):
        print(previousMenuController)
        print(menuController)
    case let .willMoveItem(menuItemView, previousMenuItemView):
        print(previousMenuItemView)
        print(menuItemView)
    case let .didMoveItem(menuItemView, previousMenuItemView):
        print(previousMenuItemView)
        print(menuItemView)
    case .didScrollStart:
        print("Scroll start")
    case .didScrollEnd:
        print("Scroll end")
    }
}
```

### Moving to a menu page programmatically

```swift
// if you pass a nonexistent page number, it'll be ignored
pagingMenuController.move(toPage: 1, animated: true)
```

### Changing PagingMenuController's option

Call `setup` method with new options again.
It creates a new paging menu controller. Do not forget to cleanup properties in child view controller.

## Requirements

- iOS 12.0+
- Swift 5.0+
- Xcode 12.0+

## Installation

### Swift Package Manager
PagingMenuController is available through [Swift Package Manager](https://swift.org/package-manager/).

#### Xcode
1. In Xcode, go to File > Add Packages...
2. Enter the repository URL: `https://github.com/tf-hnishiyama/PagingMenuController.git`
3. Select the version you want to install
4. Add PagingMenuController to your target

#### Package.swift
Add the following to your Package.swift file:
```swift
dependencies: [
    .package(url: "https://github.com/tf-hnishiyama/PagingMenuController.git", from: "2.2.0")
]
```

### CocoaPods
PagingMenuController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

pod "PagingMenuController"
```

Then, run `pod install`

In case you haven't installed CocoaPods yet, run the following command

```
$ gem install cocoapods
```

### Carthage
PagingMenuController is available through [Carthage](https://github.com/Carthage/Carthage).

To install PagingMenuController into your Xcode project using Carthage, specify it in your Cartfile:

```
github "tf-hnishiyama/PagingMenuController"
```

Then, run `carthage update`

You can see `Carthage/Build/iOS/PagingMenuController.framework` now, so drag and drop it to `Linked Frameworks and Libraries` in General menu tab with your project.
Add the following script to `New Run Script Phase` in Build Phases menu tab.
```
/usr/local/bin/carthage copy-frameworks
```

Also add the following script in `Input Files`
```
$(SRCROOT)/Carthage/Build/iOS/PagingMenuController.framework
```

In case you haven't installed Carthage yet, download the latest pkg from [Carthage](https://github.com/Carthage/Carthage/releases)

### Manual

Copy all the files in `Sources/PagingMenuController` directory into your project.

## License

PagingMenuController is available under the MIT license. See the [LICENSE](https://github.com/tf-hnishiyama/PagingMenuController/blob/master/LICENSE) file for more info.
