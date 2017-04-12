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
} from 'react-native';
import IPCSocket from 'react-native-uds';

export default class Ipcexample extends Component {
  constructor(props) {
    super(props);
    this.state = {}

  }
  onStartPressed = () => {
    IPCSocket.start()
  }

  onStopPressed = () => {
    
  }

  onConnectPressed = () => {
    
  }

  onDisconnectPressed = () => {
    
  }

  onSendMessagePressed = () => {
    
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.button}>
          <Button
            onpress= {this.onStartPressed}
            title = "Start Server"
          />
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
    marginTop: 20,
    height: 40,
    marginHorizontal: 12,
    borderColor: 'black',
    borderWidth: 1,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('Ipcexample', () => Ipcexample);
