# UI Examples

In this repository, you'll find a collection of small, reusable code snippets that you can freely use and integrate into your own projects. These tiny UI treasures have been carefully crafted, saving you time and effort in your development journey.

## Nice Button

iOS system-style button with scaling down, haptic feedback, and smoothly rounded corners that change in the pressed state. Haptic effect when pressed.

- SwiftUI


<img src="Previews/NiceButton.gif" alt="Nice Button">


## Gallery Access Restricted

User-friendly Apple-style screen that provides a step-by-step explanation of how to enable full access to the photo library after user has previously restricted it. The screen includes an 'Open Settings' button that guides users to the specific app's permission settings. Each step is accompanied by rich and fully localizable previews that replicate the appearance of the iOS Settings app. This ensures a pixel-perfect UI and system colors.

There are some delightful details: a variable background blur overlay beneath the 'Open Settings' button, consistently positioned at the bottom, and background blur applied to the small circle button, in line with Apple's design principles found in its native apps.

- SwiftUI
- Dark mode support 🌒
- iOS 16-17 different settings support


<img src="Previews/GalleryAccess.jpg" width="250px" alt="Gallery Access Restricted View">

## Ask for Notifications Permission

Apple-style implementation of a permission request screen for notifications. A user-friendly list displaying all types of notifications you can receive, along with icons (SF Symbols) and descriptions. This screen is scrollable, so you can add as many elements as you need. Selecting 'Turn on Notifications' will open a system alert requesting these permissions.

There is one delightful detail: a variable background blur overlay beneath the 'Turn on Notifications' button, consistently positioned at the bottom.

- SwiftUI
- Dark mode support 🌒

<img src="Previews/NotificationsPermission.jpg" width="250px" alt="Ask for Notifications Permission">
