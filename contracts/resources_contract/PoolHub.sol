pragma solidity ^0.4.21;
pragma experimental ABIEncoderV2;

import "./Pool.sol";
import "./HubBase.sol";

contract PoolHub is HubBase
{
	/**
	 * Constructor
	 */
	constructor()
	public
	{
	}

	/**
	 * Pool creation
	 */
	function createPool(
		address _poolOwner,
		string  _poolName,
		uint256 _subscriptionLockStakePolicy)
	public onlyOwner /*owner == IexecHub*/ returns (Pool)
	{
		Pool newPool = new Pool(_poolOwner, _poolName, _subscriptionLockStakePolicy);
		require(insert(newPool, _poolOwner));
		return newPool;
	}
}
