window.axios = require('axios').default;
window._     = require('lodash');

import Vue from 'vue';

const App = new Vue({
    el: '#app',

    data() {
        return {
            display: false,
            channel: 0,
            maxChannels: 1,
        };
    },

    computed: {
        formattedChannel() {
            if (this.channel === 0) {
                return 'Disconnect';
            }

            return this.channel + '.00 MHz';
        },
    },

    methods: {
        updateChannelCount(count) {
            this.maxChannels = count;
        },

        updateDisplay(display) {
            this.display = display;
        },

        setCurrentChannel(channel) {
            this.channel = channel;
        },

        scrollUp() {
            if (this.channel > 0) {
                this.channel--;
            }
        },

        scrollDown() {
            if (this.channel < this.maxChannels) {
                this.channel++;
            }
        },

        leftClick() {
            axios.post(`http://${GetParentResourceName()}/selectChannel`, {
                channel: this.channel,
            });
        },

        rightClick() {
            axios.post(`http://${GetParentResourceName()}/closeRadio`, {});
        },
    },
});

window.addEventListener('message', function (event) {
    if (event.data.type == 'channelCount') {
        App.updateChannelCount(event.data.count);
    }

    if (event.data.type == 'display') {
        App.updateDisplay(event.data.display);
    }

    if (event.data.type == 'currentChannel') {
        App.setCurrentChannel(event.data.channel);
    }

    if (event.data.type == 'scrollUp') {
        App.scrollUp();
    }

    if (event.data.type == 'scrollDown') {
        App.scrollDown();
    }

    if (event.data.type == 'leftClick') {
        App.leftClick();
    }

    if (event.data.type == 'rightClick') {
        App.rightClick();
    }
});