# Employee Directory

## Build tools & versions used

- Swift 5
- UIKit
- Xcode 14.0

## Steps to run the app

1. Choose the iPhone you want in simulator then run it
2. Click Sort in the navigation bar to open a dropdown with options to sort by Name or Team
4. Pull down to refresh the list. The refresh will reload the data in default order

## What areas of the app did you focus on?

### Overview

Building the UX turned out to be quite a challenge which took up the great majority of my time among figuring out cache issues.

### Framework & Interface Builder Choice

Swift and swift only is the style of choice for this project. I avoided using SwiftUI as a test of skills and to grow as an iOS developer. Until now, I haven't done many projects using soley Swift so I knew this would be a tough task given the language's complexity. In hindsight, to turn this application into exactly what I wanted it to be, SwiftUI would have been the bette choice, but no regrets here.

I chose to use UIKit throughout the application. UIKit is the foundation we all need as iOS Engineers so studying it well - practicing it thoroughly is the ultimate goal.


## What was the reason for your focus? What problems were you trying to solve?

Given the simplicity of SwiftUI, I knew I'd have a tough time figuring out how to create a solid UX using Table Views. The goal was to only allow the user to scroll through the list with the minimum necessary information and have a dropdown that opens to the rest of the employee data (phone number, biography, etc).

I wanted the user to have no problems getting to the information in a clean, quick manner. This was not a success. After spending so much time on the UX and having trouble implementing certain ideas like the dropdown, I had to scrap them and move onto other features.

## How long did you spend on this project?

Being that the goal was a well-fleshed out application, I took full advantage of a week's worth of time. Around 10 hours went into this project.

## Did you make any trade-offs for this project? What would you have done differently with more time?

I would have used SwiftUI. The knowledge that's needed to do what I wanted was beyond my current level. Using SwiftUI would have allowed a greater focus toward non-UX features.

Given the time I spent on the UX, it was time that should have been spent on tests, making sure there were no cache issues, implementing asychronous networking, and all the other little things. This was a great cost for a simple table view cell layout.

## What do you think is the weakest part of your project?

Tests were implemented but I had a build input error that couldn't be solved in time for completion. Along with not having any tests, the EmployeeListViewController and ImageExtension files could have been cleaner and more modular. I spend the entire rest of my time working on those two files to get them as best as I can without having any errors.

## Did you copy any code or dependencies? Please make sure to attribute them here!

No third-party dependencies or code was used for this project.

## Is there any other information you’d like us to know?

This is very well my first real try at a Swift only project. During my time as an apprentice in the Microsoft Leap program, I only used SwiftUI and extensively continued learning afterward without focusing much on Swift alone. I believe I did a good job considering I had to learn almost everything within the project. However, it could be a ton better. My focus is always on the customer - I would not put this code through production until heavy revisions were made.

I plan on putting my head down to learn Swift that makes me feel confident in putting out products for many, many people. I'll circle back to redo this project after completing more simple projects using API's. There's a lot to learn! 
