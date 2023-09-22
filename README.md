<a href="https://www.vcloudinfo.com" title="vCloudInfo"><noscript><img alt="vCloudInfo" src="https://www.vcloudinfo.com/wp-content/uploads/2019/01/vCloud@4x.png" data-retina="https://www.vcloudinfo.com/wp-content/uploads/2019/01/vCloud@4x.png"/></a>
<div align="center">
	
[![Twitter Follow](https://img.shields.io/twitter/follow/ccostan?color=blue&amp;label=talk&amp;logo=twitter&amp;style=for-the-badge)](https://twitter.com/ccostan)
[![YouTube Subscribe](https://img.shields.io/youtube/channel/subscribers/UC301G8JJFzY0BZ_0lshpKpQ?label=VIEW&logo=Youtube&logoColor=%23DF5D44&style=for-the-badge)](https://www.youtube.com/vCloudInfo?sub_confirmation=1)
[![GitHub Follow](https://img.shields.io/github/stars/CCOSTAN/Home-AssistantConfig?label=Code&amp;logo=Github&amp;style=for-the-badge)](https://github.com/CCOSTAN)
	
</div>

# DVTimer: Stand-Up Reminder via Windows Task Scheduler
AutoHotKey Script to remind me to get up and Walk to prevent DVTs and Blood Clots!

This script will just sit in the Tool Tray and pop up a message to remind you to walk every 45 minutes or so.(Adjustable).

Resets counters everytime the laptop sleeps and wakes up.

## Requirements

- Windows 10 or higher
- Administrative rights for Task Scheduler setup

## Instructions

### Open Task Scheduler

Search for "Task Scheduler" in the Windows search bar and run it as an administrator.

### Create New Task

1. **Right Panel**: Click on "Create Basic Task" in the right-hand panel.
2. **Name and Description**: 
    - **Name**: DVTimer
    - **Description**: A task to run the `WAKEuP.CMD` batch file.

### Configure Triggers

1. **Triggers Tab**: Navigate to the "Triggers" tab and click on "New."
2. **Trigger Settings**: 
    - **Trigger Type**: Choose "At log on" and "On workstation unlock."
    - **User**: Set this to your specific user account.

### Configure Actions

1. **Actions Tab**: Navigate to the "Actions" tab and click on "New."
2. **Action Settings**: 
    - **Action**: Choose "Start a program."
    - **Program/script**: Enter the full path to your `WAKEuP.CMD` batch file.

**Example**: 
- Program/script: `"C:\\path\\to\\WAKEuP.CMD"`

### Finalize Configuration

Review all the settings to ensure they match your needs, then click "OK" to save your settings.

### Testing and Verification

1. **Test**: Right-click on the task and select "Run" to test it.
2. **Verify**: Check the Task Scheduler "History" tab for logs, or manually trigger the task to ensure it's functioning as expected.


