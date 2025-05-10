# Among Them - Documentation

## Application Overview
Among Them is an iOS application that offers users various chatbots to interact with, chat with, and ask questions to. These bots include but are not limited to: Dietitian, Fitness Coach, Doctor, Therapist, and Random/Miscellaneous Help. The application also includes a fun horror game that puts the user into the shoes of a vampire, in which the user must trick the AI to win and also a "gaslighting" game where the user must convince the AI that they are another AI model themselves. 

### Key Features

 - Many different kinds of chatbots to chat and interact with
 - Save multiple different chats/threads with different bots at once
 - Delete chats/threads with bots
 - Aesthetically pleasing interface and UI

### Target Audience

 - Age: 18-65
 - Gender: All Genders
 - Education: Any education level
 - Values: Looking to better help themselves with advice
 - Interests: Technology, Fitness, Health, Cooking, Gaming

### Platform

 - Only iOS is supported
 - Possible Android support in the future

### Authors
1. [@MattRStoffel](https://github.com/MattRStoffel) - Matt Stoffel
2. [@MaKoabra](https://github.com/MaKoabra) - Steven Brandt
3. [@adixsharma](https://github.com/adixsharma) - Aditya Sharma
4. [@natdav231](https://github.com/natdav231)  - Nathan Gabriel David

## User Manual

### Installation/Getting Started
#### Apple Store
Among Them is currently planned to be published in the Apple App Store for iOS devices. Users will be required to sign in into the App Store via their Apple ID in order to install any applications from said store. 

#### Current Method (Installation via GitHub)
##### Requirements for this method:

 - Up-to-date Macintosh OS device with Xcode installed
 - Access to the GitHub link/page
 - Access/Permission from the authors

Below is the step-by-step tutorial on how to install this application for use and testing on a Macintosh OS device. 
 

 1. Clone the repository from the GitHub link/page. 
**git clone (insert link here)** 
 2. Ensure that ollama is installed by running the first command below in your machine's terminal. If it returns a number, then run the second command to run the AI model. 
**ollama -v**
**ollama run llama3.2**
 4. Once both steps are completed, open the cloned file titled "**AmongThem**" using Xcode.
 5. Run the program by pressing the big play button on the top left of Xcode. 
 6. Enjoy!

#### How to Play
Upon opening up Among Them, you will be greeted with the home page. The home page contains two buttons, **Play** and **Help**. If you require any help regarding basic functions of the app, press the **Help** button. 

When you press the **Play** button, you are greeted with a view of all your current chats with bots. This view may be empty if this is your first time playing. 

To start a new chat with a bot, press the **cross icon** on the top right of the screen and select a bot from the drop-down menu. 

Once you have created a bot, you can either click on a chat from the chat view to start chatting with the bot or swipe left on an existing chat to delete that chat. *Currently, chats are saved locally on your device and do not carry over if the app is deleted or used on another device.*

After clicking on a chat, you will be greeted with a starry background similar to the main menu page. At the bottom, you will see a text box that you can use to start chatting with the bot. 

After sending a message to the bot, you will have to wait a few seconds for it to respond. 

Once you are done chatting with the bot, you can go back to all the chats you have using the **Back** button located on the top left of the screen. 

#### UI Overview

 - ****Main Page****
 Contains **Play** and **Help** buttons 
 
 - ****Help Page****
 Contains basic instructions on how to navigate through the app
  
 - ****Threads/Chats Page****
 Shows all current threads/chats the user has. Allows the user to create new chats. 
 
- ****Individual Thread/Chat Page****
Allows the user to chat with a selected bot.

#### Accessibility Features

 - None :(

### Features and Functionality (Detailed)
- ****Multiple Threads****
Create multiple threads using the plus sign in the Threads/Chats Page. Multiple different threads/chats can be accessed and kept at once. 

- ****AI Chat powered by Ollama 3.2****
Chat with the bots using the text box at the bottom of the individual Thread/Chat Page. Whenever you send a message to the bot, it will indicate that the bot is typing up a response. Be patient, as it could take a few seconds for the bot to come up with a response. 

- ****Data Persistance****
All threads/chats are stored locally on your device, so do not fear losing any chats, and the app can be used offline. Chats are not saved when using the app on a different device or if the app is deleted. 

## Technology Stack
- ****Ollama 3.2****
Used to operate all the different chatbots in the application.
- ****Xcode 16.2****
Used to create, edit, test, and compile the application. 
- ****Swift 5.9****
An open-source programming language used in the creation of the application.
- ****SwiftUI****
Used to create the clean visuals and UI. 



