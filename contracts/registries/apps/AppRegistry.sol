pragma solidity ^0.6.0;

import '../Registry.sol';
import './App.sol';


contract AppRegistry is Registry
{
	/**
	 * Constructor
	 */
	constructor()
	public Registry(
		address(new App()),
		"iExec Application Registry (V5)",
		"iExecAppsV5")
	{
	}

	/**
	 * App creation
	 */
	function createApp(
		address          _appOwner,
		string  calldata _appName,
		string  calldata _appType,
		bytes   calldata _appMultiaddr,
		bytes32          _appChecksum,
		bytes   calldata _appMREnclave)
	external returns (App)
	{
		return App(_mintCreate(
			_appOwner,
			abi.encodeWithSignature(
				"initialize(string,string,bytes,bytes32,bytes)",
				_appName,
				_appType,
				_appMultiaddr,
				_appChecksum,
				_appMREnclave
			)
		));
	}
}