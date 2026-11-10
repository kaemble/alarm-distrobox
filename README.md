# alarm-distrobox
Script to create a container image based on Arch Linux ARM (ALARM) releases usable by distrobox.

`git clone https://github.com/kaemble/alarm-distrobox.git`
`cd alarm-distrobox`
`./build.sh`
`distrobox create --name alarm --image localhost/alarm-distrobox:latest`
`distrobox enter alarm`