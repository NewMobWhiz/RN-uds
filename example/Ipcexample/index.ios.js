/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Button,
  TextInput,
} from 'react-native';
import IPCSocket from 'react-native-uds';

export default class Ipcexample extends Component {
  constructor(props) {
    super(props);
    this.state = {
      text: '',
      isStart: false
    };

  }
  onStartPressed = () => {
    console.log('start button pressed');
    IPCSocket.startServer().then(val => this.setState({isStart:val}))
  }

  onStopPressed = () => {
    console.log('stop button pressed');
  }

  onConnectPressed = () => {
    console.log('connect button pressed');
  }

  onDisconnectPressed = () => {
    console.log('disconnect button pressed');
  }

  onSendMessagePressed = () => {
    console.log('send button pressed');
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.button}>
          <Button
            onPress= {this.onStartPressed}
            title = "Start Server"
          />
          <Button
            onPress= {this.onStopPressed}
            title = "Stop Server"
          />
          <Button
            onPress= {this.onConnectPressed}
            title = "Connect Client"
          />
          <Button
            onPress= {this.onDisconnectPressed}
            title = "Disconnect Client"
          />
          <Button
            onPress= {this.onSendMessagePressed}
            title = "Send Message"
          />
          <TextInput
            style={styles.textinput}
            placeholder="Type here to send!"
            onChangeText={(text) => this.setState({text})}
          />
          <Text style={{padding: 10, fontSize: 28}}>
            {this.state.text}
          </Text>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 20,
    // justifyContent: 'center',
    // alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  button: {
    marginTop: 10,
    height: 40,
    marginHorizontal: 12,
    // borderColor: 'black',
    // borderWidth: 1,
  },
  textinput: {
    marginTop: 10,
    height: 40,
    marginHorizontal: 12,
    borderColor: 'black',
    borderWidth: 1,
  },
});

AppRegistry.registerComponent('Ipcexample', () => Ipcexample);
