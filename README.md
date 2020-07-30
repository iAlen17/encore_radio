# encore_radio

Customizable framework agnostic radio script for FiveM and TokoVoip built for [Encore RP](https://discord.gg/encorerp).

## Installation

### Prerequisites

TokoVoip 1.2.x or 1.5.x is required to use encore_radio.

### Installation

Assuming you are using a pre-compiled version from Releases, simply add the `encore_radio` folder to your FiveM resources folder and ensure the script is started.

### Compiling

This resource's NUI is built using Vue.js. To build the distribution assets, you will need Node.js. Run `npm install && npm run prod` from the `nui` folder.

## Configuration

Most configuration can be done in the `~/config.lua` file.

* `NumberOfChannels`: The number of radio channels you have, or want to allow.
* `EnableRadioCommand`: Enables using `/radio` to open the radio. You might want to disable this if you are using some sort of inventory system.
* `RadioCommand`: The command that opens the radio. `/radio` by default.
* `Updates.CheckForUpdates`: Enables automatically checking for updates when the resource starts.

### Advanced Usage

#### Client Events

* `encore_radio:openRadio`: Trigger this event (from client or server) to open the radio. Useful for inventory systems.
* `encore_radio:closeRadio`: Trigger this event (from client or server) to close the radio.
* `encore_radio:turnOffRadio`: Trigger this event (from client or server) to close and turn off the radio. Useful if you want radios to shut off the player's radio when they are downed, jailed, etc.

#### Client Functions

* `canJoinChannel()`: You can edit this function in `client/client.lua` to restrict access to some channels. Return true if the user is allowed to join the given channel, or false if not.
* `showNotification()`: You can customize this to use another notifications system (for example, mythic_notify.)

## Support

Support for specific framework integrations is not provided. If you need general support, or have found a bug, feel free to open an issue or submit a pull request.

## License

encore_radio is licensed under the MIT license. See [LICENSE.md](LICENSE.md) for more details.