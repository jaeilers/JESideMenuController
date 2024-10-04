# JESideMenuController
![CI](https://github.com/jaeilers/JESideMenuController/workflows/CI/badge.svg) [![codecov](https://codecov.io/gh/jaeilers/JESideMenuController/branch/main/graph/badge.svg?token=uiHfbQtqm0)](https://codecov.io/gh/jaeilers/JESideMenuController) ![](https://img.shields.io/badge/license-MIT-lightgrey.svg) ![](https://img.shields.io/badge/Swift-5.10-orange.svg) ![](https://img.shields.io/badge/Xcode-15.4+-blue.svg) ![](https://img.shields.io/badge/iOS-15+-blue.svg)

The `JESideMenuController` is a custom container controller that manages a side menu and the currently selected content. It supports different styles such as: slide-out, slide-in (navigation drawer) and slide-out the menu and content simultaneously. This controller supports initialization via storyboards or in code and is Safe Area compatible.

## Features

- [x] Styles: slide-out, slide-in, slide-out inline (slide out the menu and content at the same time)
- [x] Left or right side
- [x] Storyboards & code
- [x] Portrait & landscape
- [x] iPhone & iPad support
- [x] Safe Area support

slide out | slide in | slide out inline
--- | --- | ---
![](Example/resources/slide-out.gif) | ![](Example/resources/slide-in.gif) | ![](Example/resources/slide-out-inline.gif)

## Installation

[Swift Package Manager](https://github.com/apple/swift-package-manager) is the official dependency manager for Cocoa projects. Swift PM is directly integrated since Xcode 11. Add the url of this repository to your dependencies in Xcode or add the following line to your `Package.swift` as a value in `dependencies`:

```
dependencies: [
	.package(url: "https://github.com/jaeilers/JESideMenuController.git", from: "2.0.0")
]
```

## How to use

### Set-up via Code

The `JESideMenuController` provides default arguments for initialization. You can provide the menu view controller and first visible view controller, that will be displayed at launch, after initialization.

```swift
let menuViewController = ...
let rootViewController = ...
let sideMenuController = JESideMenuController()

sideMenuController.setMenuViewController(menuViewController)
sideMenuController.setViewController(rootViewController, animated: false)
...
```

You may also provide the menu view controller upon initialization:

```swift
...
let menuViewController = ...
let sideMenuController = JESideMenuController(menuViewController: menuViewController)
...

```

The default values are a slide-out menu on the left side. To choose a different configuration use the following constructor signature:

```swift
...
let sideMenuController = JESideMenuController(
	style: .slideIn,
	isLeft: false
)
...
```

The following constants of `JESideMenuController.Style` are available as arguments for the style parameter: `.slideOut`, `.slideIn`, `.slideOutInline`. Left and right position are available for all styles.

### Storyboards

Set the `JESideMenuController` as your root view controller in your `Main.storyboard` and set-up a menu (table) view controller and a root view controller. Add the Storyboard identifiers as values to the user defined runtime attributes `menuId` and `rootId` in `JESideMenuController`. They are also available as inspectable attributes. To configure the position (left/right), enter a boolean value in the inspectable attribute `isLeft`. Default is `true` for a left side menu. To adjust the style of the slider, enter a number (0...2) in `Layout Style`:

![](Example/resources/storyboardInspectableProperties.png)

- 0: slide-out
- 1: slide-in
- 2: slide-out inline (twitter style)

For more information, refer to the example project.

### API - JESideMenuController

You can access the `JESideMenuController` instance due to a `UIViewController` extension. 

```swift
public var sideMenuController: JESideMenuController? { get }
```

#### Enable/disable scrolling
```swift
public var isScrollEnabled: Bool { get set }
```

#### Set a new menu view controller
```swift 
/// Set a view controller that will be displayed as the menu.
public func setMenuViewController(_ viewController: UIViewController)

// Example:
let newMenuViewController = ...
sideMenuController?.setMenuViewController(newMenuViewController)
```

#### Set a new view controller and hide the menu
```swift
/// Set and display a new root view controller and hide the menu (animated).
public func setViewController(_ viewController: UIViewController, animated: Bool = true)

// Example:
let newViewController = ...
sideMenuController?.setViewController(newViewController)
// or
sideMenuController?.setViewController(newViewController, animated: true)
```

#### Toggle the state of the menu
```swift
/// Hides or reveals the menu based on the current state.
public func toggle(animated: Bool = true)

// Example:
sideMenuController?.toggle()
```

#### Set the state of the menu
```swift
/// Set the hidden state of the menu. Optionally animated.
public func setMenuHidden(_ isHidden: Bool, animated: Bool)

// Example:
sideMenuController?.setMenuHidden(true, animated: true)
```

#### Determine the state of the menu
```swift
public var isMenuVisible: Bool { get }

// Example:
sideMenuController?.isMenuVisible
```

#### Adjust the configuration 
You may adjust the configuration of the slider to your projects needs via `JESideMenuController.Configuration`.

```swift
let config = JESideMenuController.Configuration(
	spacing: 100,
	ipadWidth: 400,
	tintColor: .gray,
	hasDropShadowImage: true,
	dropShadowImage: UIImage(name: ...)
)
let sideMenuController = JESideMenuController(configuration: config)
...
```

## License
This framework is released under [MIT License](./LICENSE.md).