pragma solidity ^0.5.0;

import './Registry.sol';
import './CounterfactualFactory.sol';
import './App.sol';


contract AppRegistry is Registry, CounterfactualFactory
{
	event CreateApp(address indexed appOwner, address app);

	/**
	 * Constructor
	 */
	constructor(address _previous)
	public Registry(_previous)
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
		bytes32 salt = keccak256(abi.encodePacked(
			_appName,
			_appType,
			_appMultiaddr,
			_appChecksum,
			_appMREnclave
		));

		App app = App(_create2(type(App).creationCode, salt));
		app.setup(
			_appName,
			_appType,
			_appMultiaddr,
			_appChecksum,
			_appMREnclave
		);

		_mint(_appOwner, uint256(address(app)));
		emit CreateApp(_appOwner, address(app));

		return app;
	}

}
